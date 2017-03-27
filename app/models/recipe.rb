class Recipe < ApplicationRecord
  belongs_to :chef, { :optional => false }
end
