class FlashcardsController < ApplicationController
	before_action :signed_in_user, only: [:translate]

	def index
		if signed_in?
			link = Link.find_by(user_id: current_user.id)
			if !link.nil?
				words_id = link.words_id.split('|')
				@count = words_id.length
				if !(@count == 0)				
					if @count < 6
						i = 0
					else
						@count = 5
						i = rand(@count - 4) + 1
					end
					@words = []
					@count.times do |j|
						@words << Word.find(words_id[i+j-1])
					end
				end
			end
		end	
	end

	def translate		
		@text = params[:text]
		if !@text.blank?
			word = Word.find_by(en: @text.downcase)
			
			if word.nil?
				bing = BingTranslatorSetting.find(1)
				translator = BingTranslator.new(bing.client_id, bing.client_secret)
				@resualt = translator.translate @text, :from => 'en', :to => 'ru'
				word = Word.new(en: @text.downcase, ru: @resualt.downcase)

				if !word.save
					render 'index'
				end
			else
				@resualt = word.ru
			end

			link = Link.find_by(user_id: current_user.id)
			if link.nil?
				link = Link.new(user_id: current_user.id, words_id: word.id.to_s)
			else
				words_id = link.words_id.split('|')
				if !words_id.include?(word.id.to_s)
					link.words_id += '|' + word.id.to_s
				end
			end
			link.save
			redirect_to '/', alert: @resualt

		else
			flash.now[:error] = 'Для перевода заполните поле'
			render 'index'
		end
		
	end
end
