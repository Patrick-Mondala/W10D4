# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
    belongs_to :author,
        class_name: 'User',
        foreign_key: :author_id

    has_many :post_subs
    has_many :subs,
        through: :post_subs,
        source: :sub
end