class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :steps
  mount_uploader :cover, CoverUploader

  before_validation :generate_slug
  validates_presence_of :title, :description
  validate :capitalize

  def to_param
    slug
  end

  private
  def capitalize
    self.title = self.title.capitalize
    self.description = self.description.capitalize
  end

  def generate_slug
    pattern = self.title.parameterize
    duplicates = Recipe.where("slug LIKE ?", "#{pattern}")

    unless duplicates.empty?
      self.slug = "#{pattern}-#{duplicates.count+1}"
    else
      self.slug = pattern
    end
  end
end
