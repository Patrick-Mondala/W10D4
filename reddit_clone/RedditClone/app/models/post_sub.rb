class PostSub < ApplicationRecord
    validates :sub_id, :post_id, null: false

    belongs_to :sub
    belongs_to :post
end