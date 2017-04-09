class Message < ApplicationRecord

  belongs_to :chef
  validates :content, presence: true
  validates :chef_id, presence: true

  scope :sorted_by_time, lambda { order("created_at DESC").first(20) }

  def self.most_recent
    order(:created_at).first(20)
  end

end
