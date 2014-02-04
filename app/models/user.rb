class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups

  delegate :notes, to: :groups

  after_create :create_default_group

  def create_default_group
    group = Group.new
    group.name = self.email.concat '-default'
    group.users << self
    if group.save
      self.groups << group
    else
      # ?????? group does not save so there's no default group
      binding.pry
    end
  end
end
