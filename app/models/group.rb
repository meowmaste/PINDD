class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :notes, dependent: :destroy

  validates :name, presence: true

  def before_save
    self.email = self.email.downcase
  end

  def member_to_add
  end

  def member_to_remove
  end

  def add_member(user_email = nil)
    if user_email
      user = User.find_by(email: user_email.downcase)
      self.users << user unless self.users.include?(user)
    end
    user ? true : false
  end

  def remove_member(user_email = nil)
    if user_email
      user = User.find_by(email: user_email)
      self.users.delete(user)
    end
    user ? true : false
  end
end
