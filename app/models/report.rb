class Report < ApplicationRecord
    has_one_attached :photo
    validates :user, presence: true
    validates :tittle, presence: true
    validates :description, presence: true

    belongs_to :category
end
