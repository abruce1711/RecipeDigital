class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :item
  validates_presence_of :amount
  validate :capitalize, :trim_amount_zeros

  private
  def capitalize
    self.item = self.item.capitalize
  end

  def trim_amount_zeros
    if self.amount == self.amount.to_i
      self.amount = self.amount.to_i
    end
  end
end
