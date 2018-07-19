class Step < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :content
  validate :capitalize

  private
  def capitalize
    self.content = self.content.capitalize
  end

end
