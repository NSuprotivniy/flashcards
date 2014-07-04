class Word < ActiveRecord::Base
	before_save { en.downcase! }
	before_save { ru.downcase! }


	belongs_to :user

	validates :en, presence: {message: "Для перевода заполните текстовое поле"}
	validates :user_id, presence: true
end
