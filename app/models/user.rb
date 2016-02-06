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
    
    # フォローしているUser
    has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    # フォローされているUser
    has_many :follower_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    # 他のユーザーをフォローする
      def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
      end

    # フォローしているユーザーをアンフォローする
      def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
      end

    # あるユーザーをフォローしているかどうか？
      def following?(other_user)
        following_users.include?(other_user)
      end
      
    
      
end
