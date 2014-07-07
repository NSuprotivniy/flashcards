class Word < ActiveRecord::Base
	before_save { en.downcase! }
	before_save { ru.downcase! }

	has_and_belongs_to_many :users

	validates :en, presence: {message: "Для перевода заполните текстовое поле"},
		uniqueness: { case_sensitive: false, 
			message: "Что-то не так, такая запись уже имеется."}
end
