class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :tweets, dependent: :destroy #追記 ユーザーが削除されたら、ツイートも削除されるようになります。すでに書いてある場合は追記しなくて大丈夫です。
         validates :name, presence: true #追記
         validates :profile, length: { maximum: 200 } #追記

         has_many :likes, dependent: :destroy
         has_many :liked_tweets, through: :likes, source: :tweet

         def already_liked?(tweet)
          self.likes.exists?(tweet_id: tweet.id)
        end

        has_many :comments, dependent: :destroy

        has_many :messages, dependent: :destroy
        has_many :entries, dependent: :destroy

        has_many :relationships
        has_many :followings, through: :relationships, source: :follow
        has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
        has_many :followers, through: :reverse_of_relationships, source: :user
      
        def follow(other_user)
          unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
          end
        end
      
        def unfollow(other_user)
          relationship = self.relationships.find_by(follow_id: other_user.id)
          relationship.destroy if relationship
        end
      
        def following?(other_user)
          self.followings.include?(other_user)
        end

        mount_uploader :image, ImageUploader
      
end
