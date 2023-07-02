class Category < ApplicationRecord
    has_many :reports, dependent: :restrict_with_exception
end
