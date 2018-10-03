class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :steps
  has_many :comments
  belongs_to :user, optional: true
  has_and_belongs_to_many :tags
  mount_uploader :cover, CoverUploader

  before_validation :generate_slug
  validates_presence_of :title, :description, :tags, on: :create
  validates_presence_of :title, :description, :tags, on: :update
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

  def add_tag(tag)
    # checks if tag already exists, if not it creates it, if it does it just creates an association
    previous_tag = Tag.where(content: tag)
    if previous_tag.empty?
      self.tags.build(content: tag)
    else
      self.tags << previous_tag
    end
  end

  def add_tags(tags)
    tag_list = tags.split(',')
    tag_list.each do |tag|
      tag_content = tag.gsub(/[\W]/, '')
      add_tag(tag_content)
    end
  end

  def update_tags(tags)
    if tags.count("a-zA-Z") == 0
      return false
    end
    # list of new tags
    parameter_list = tags.split(',')

    # empty lists for current tags and new tag content
    current_tag_list = []
    new_tag_list = []

    # loop through each of the tags past in
    if !parameter_list.empty?
      parameter_list.each do |new_tag|

        # remove symbols and add to ntag list
        new_tag_content = new_tag.gsub(/[\W]/, '')
        new_tag_list.push(new_tag_content)
      end
    end

    # loops through each current tag object
    self.tags.each do |tag|
      # get the content from the object and put it in the ctag list
      puts "TEST COMPLETE INSIDE LOOP"
      current_tag_content = tag.content.gsub(/[\W]/, '')
      current_tag_list.push(current_tag_content)

      # if there's a tag in our current list that's not in the new tags, remove it
      if !new_tag_list.include? current_tag_content

        # check if it only belongs to this recipe, if so delete it altogether
        # if not just remove the association
        if tag.recipes.length == 1
          tag.destroy
        else
          self.tags.delete(tag)
        end
      end
    end

    # loops through the new tags
    new_tag_list.each do |tag|

      # if there's a new tag not in our list then add it
      if !current_tag_list.include? tag
      add_tag(tag)
      end
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
