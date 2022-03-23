class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    validates :body, presence: true, allow_blank: false, length: { minimum: 1 }
end
