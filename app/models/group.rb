class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :notes, dependent: :destroy

  validates :name, presence: true

  def add_member(user)
  end

  def remove_member(user)
  end
end
