class Word < ActiveRecord::Base
	before_save { en.downcase! }
	before_save { ru.downcase! }


	belongs_to :user

	validates :en, presence: true
	validates :user_id, presence: true
end
