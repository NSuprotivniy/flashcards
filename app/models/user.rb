class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	has_many :words, dependent: :destroy

	validates :name, presence: {message: "Поле имени пользователя не может быть пустым"}, 
		length: { maximum: 50,
			message: "Имя пользователя слишком длинное(максимум 50 символов" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: {message: "Поле электронной почты не может быть пустым"},
		format: { with: VALID_EMAIL_REGEX,  
			message: "Не правильный адрес электронной почты"}, 
		uniqueness: { case_sensitive: false ,  
			message: "Пользователь с таким адресом электронной почты уже существует"}
    has_secure_password
    validates :password, presence: {message: "Поле пароля не может быть пустым"},
    	length: { minimum: 6 ,  
			message: "Пароль должен быть не менее 6 символов"}

    def User.new_remember_token
	    SecureRandom.urlsafe_base64
	 end

	def User.encrypt(token)
	    Digest::SHA1.hexdigest(token.to_s)
	end

	 private

	    def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end
end
