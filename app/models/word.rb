class Word < ActiveRecord::Base
	before_save { self.en = en.downcase }
	before_save { self.ru = email.ru }

	validates :en, presence: true, uniqueness: { case_sensitive: false }
end
