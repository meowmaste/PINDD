class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :notes

  validates :name, presence: true

  def add_member
  end

  def remove_member
  end
end
