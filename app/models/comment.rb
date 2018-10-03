class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates_presence_of :title, :body, :rating
end
