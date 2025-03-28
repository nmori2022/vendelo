class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, 
        length: {in: 6..100}, 
        format: {
            with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
            message: "only allows letters, numbers, and .-_@ characters"
        }
    validates :username, presence: true, uniqueness: true, 
        length: {in: 3..15}, 
        format: {
            with: /\A[a-zA-Z0-9_]+\z/,
            message: "only allows letters, numbers and underscores"
        }
    validates :password, presence: true, length: { minimum: 6 }

    has_many :products, dependent: :restrict_with_exception    

    before_save :downcase_attributes

    private
        def downcase_attributes
            self.email = email.downcase
            self.username = username.downcase
        end
end
