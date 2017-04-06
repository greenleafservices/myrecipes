class Recipe < ApplicationRecord

  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :synopsis, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 5, maximum: 2056 }
  belongs_to :chef
  has_many :recipe_ingredients
  validates :chef_id, presence: true
  scope :latest, lambda { order("updated_at DESC") }


  has_many :ingredients, through: :recipe_ingredients


end
