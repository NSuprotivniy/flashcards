class FlashcardsController < ApplicationController
	before_action :signed_in_user, only: [:translate]

	def index
		if signed_in?
			@words = current_user.words.order("RANDOM()").limit(5)
			@count = @words.length
		end	
	end

	def create	
		text = params[:text]
		text.downcase!
		if text.blank?
			flash.now[:error] = 'Для перевода заполните поле'
			render 'index'
		else
			word = Word.find_by(en: text)
			if word.nil?				
				resualt = translate('en', 'ru', text)
				word = Word.create(en: text, ru: resualt)
			end			
			current_user.words << word unless current_user.words.include?(word)
			redirect_to '/', alert: @resualt
		end	
	end


	def translate(input_lang, output_lang, text)
		bing_secret = File.open("#{Rails.root}/.bing_secret", 'r').read.split(' ')
		id = bing_secret[0]
		secret = bing_secret[1]
		translator = BingTranslator.new(id, secret)
		return translator.translate text, :from => input_lang, :to => output_lang
		
	end
end