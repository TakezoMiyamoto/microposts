class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 225 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :origin, presence: true, length: { maximum: 30 }, on: :update
    validates :profile, presence: false, length: { maximum: 150 }
    has_secure_password
    validates :password, presence: true, length: { minimum: 4 }
    
    has_many :microposts
end
