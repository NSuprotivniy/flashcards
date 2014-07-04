class FlashcardsController < ApplicationController
	before_action :signed_in_user, only: [:translate]

	def index
		if signed_in?
			words = current_user.words
			if !(words.length == 0)
				@words_en = []
				@words_ru = []
				@count = words.length
				if @count < 6
					i = 0
				else
					@count = 5
					i = rand(@count - 4) + 1
				end
				
				@count.times do |j|
					word = words[i+j]
					@words_en << word.en
					@words_ru << word.ru
					
				end
			end
		end	
	end

	def translate		
		@text = params[:text]
		if !@text.blank?
			translator = BingTranslator.new('rails_translator', 'Sztgywbz+QW9+T0hdWL5oyTNI0UCN3wb+GtShaS21Nk=')
			@resualt = translator.translate @text, :from => 'en', :to => 'ru'
			@word = current_user.words.build(en: @text.downcase, ru: @resualt.downcase)
			if @word.save
				redirect_to '/', alert: @resualt
			else
				render 'index'
			end
		else
			flash.now[:error] = 'Для перевода заполните поле'
			render 'index'
		end
		
	end
end
