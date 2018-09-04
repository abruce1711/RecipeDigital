class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  validates_uniqueness_of :username
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  before_validation :generate_slug
  validate :capitalize

  def to_param
    slug
  end

  private
  def generate_slug
    self.slug = self.username.parameterize
  end

  def capitalize
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end

end
