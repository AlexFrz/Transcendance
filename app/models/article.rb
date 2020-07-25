class Article < ApplicationRecord
    belongs_to :category
    has_one_attached :image
    belongs_to :user

end
