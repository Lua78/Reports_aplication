class Report < ApplicationRecord
    TIME_FILTER_ADMIN = {
        all: "1=1",
        today:"extract (DOY FROM created_at) >= extract(DOY FROM CURRENT_DATE)",
        week: "extract (DOY from  created_at) >= extract(DOY FROM CURRENT_DATE)-6"
    }
    TIME_FILTER = {
        all: "1=1 and user_id = #{Current.user::id}",
        today:"extract (DOY from  created_at) >= extract(DOY from CURRENT_DATE) and user_id = #{Current.user::id}",
        week: "extract (DOY from  created_at) >= extract(DOY from CURRENT_DATE)-6 and user_id = #{Current.user::id}"
    }
    has_one_attached :photo
    validates :nameuser, presence: true
    validates :user_id, presence: true
    validates :tittle, presence: true
    validates :description, presence: true

    belongs_to :category
    belongs_to :user, default: ->{ Current.user }

end
