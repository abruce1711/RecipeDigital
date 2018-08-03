class User < ApplicationRecord
  has_many :recipes
  validates_uniqueness_of :username
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  before_validation :generate_slug

  def to_param
    slug
  end

  private
  def generate_slug
    self.slug = self.username.parameterize
  end

end
