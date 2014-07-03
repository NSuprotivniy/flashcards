class FlashcardsController < ApplicationController

	def index
		@words_en = []
		@words_ru = []
		if Word.count < 6
			@count = Word.count
			i = 1
		else
			@count = 5
			i = rand(Word.count - 4) + 1
		end
		
		@count.times do |j|
			@word = Word.find(i+j)
			@words_en << @word.en
			@words_ru << @word.ru
			
		end		
	end

	def translate

		translator = BingTranslator.new('rails_translator', 'Sztgywbz+QW9+T0hdWL5oyTNI0UCN3wb+GtShaS21Nk=')
		@text = params[:text]
		@resualt = translator.translate @text, :from => 'en', :to => 'ru'
		Word.create(en: @text, ru: @resualt.downcase)
		redirect_to '/', alert: @resualt
	end
end
