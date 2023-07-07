class Report < ApplicationRecord
    TIME_FILTER = {
        all: "1=1",
        today:"extract (DAY from  created_at) >= extract(day from CURRENT_DATE)",
        week: "extract (DAY from  created_at) >= extract(day from CURRENT_DATE)-6"
    }

    has_one_attached :photo
    validates :nameuser, presence: true
    validates :user_id, presence: true
    validates :tittle, presence: true
    validates :description, presence: true

    belongs_to :category
    belongs_to :user, default: ->{ Current.user }
end
