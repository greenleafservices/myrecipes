class Ingredient < ApplicationRecord

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: {minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  scope :sorted, lambda { order("name ASC") }
end
