class User < ApplicationRecord
    has_secure_password
    
    validates :name, presence: true,
    format: {
        with: /\A[ a-z-A-Z]+\z/,
        message: :invalid
    }


    validates :username, presence: true, uniqueness: true,
    length: { in: 4..15 },
    format: {
        with: /\A[ a-z-A-Z-0-9]+\z/,
        message: :invalid
    }
    validates :password, presence: true, length: { minimum: 6 }

    before_save :down_user

    private

    def down_user
        self.username = username.downcase
    end
end
