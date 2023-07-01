class Report < ApplicationRecord
    has_one_attached :photo
    validates :user, presence: true
    validates :tittle, presence: true
    validates :description, presence: true
end
