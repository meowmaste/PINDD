class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_create :setup_default_role_for_new_users

  has_and_belongs_to_many :groups

  delegate :notes, to: :groups

  ROLES = %w[admin default]

  private

  def setup_default_role_for_new_users
    if self.role.blank?
        self.role = "default"
    end 
  end 

end
