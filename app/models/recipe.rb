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

  def destroy_recipe
    self.ingredients.destroy_all
    self.steps.destroy_all
    self.destroy
  end

  private
  def capitalize
    self.title = self.title.capitalize
    self.description = self.description.capitalize
  end

  def generate_slug
    pattern = self.title.parameterize
    duplicates = Recipe.where("slug LIKE ?", "#{pattern}")

    if duplicates.empty?
      self.slug = pattern
    else
      self.slug = "#{pattern}-#{duplicates.count+1}"
    end
  end
end
