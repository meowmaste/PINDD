class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :notes, dependent: :destroy

  validates :name, presence: true

  def before_save
    self.email = self.email.downcase
  end

  def add_member
  end

  def remove_member
  end
end
