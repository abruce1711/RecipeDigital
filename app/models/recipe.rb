class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :steps
  has_many :comments
  belongs_to :user, optional: true
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

  def own_recipe(recipe, user)
    recipe.user_id == user.id
  end

  def publish_recipe
    if self.steps.length == 0 || self.ingredients.length == 0
      false
    else
      self.update_attributes(:published => true)
      true
    end
  end

  def average_rating
    total_rating = 0.0
    number_of_ratings = 0.0
    if self.comments.length > 0
      self.comments.each do |comment|
        rating = comment.rating
        total_rating += rating
        number_of_ratings += 1
      end
      (total_rating / number_of_ratings).round
    else
      0
    end
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

  def associate_user
    self.user_id == current_user.id
  end
end
