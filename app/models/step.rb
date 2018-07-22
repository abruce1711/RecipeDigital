class Step < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :content
  validate :capitalize

#  def self.move_step_up(steps, index)
#    moved_up = steps[index]
#    moved_down = steps[index-1]
#    moved_up.content, moved_down.content = moved_down.content, moved_up.content
#    moved_up.save
#    moved_down.save
#  end

  private
  def capitalize
    self.content = self.content.capitalize
  end

end
