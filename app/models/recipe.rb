class Recipe < ApplicationRecord

  belongs_to :chef
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  scope :latest, lambda { order("updated_at DESC") }

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :chef_id, presence: true
end
