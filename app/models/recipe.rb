class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :steps
  mount_uploader :cover, CoverUploader

  validates_presence_of :title, :description
  validate :capitalize

  private
  def capitalize
    self.title = self.title.capitalize
    self.description = self.description.capitalize
  end
end
