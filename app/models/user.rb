class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: true
  before_create :setup_default_role_for_new_users

  has_and_belongs_to_many :groups

  delegate :notes, to: :groups

  ROLES = %w[admin default]

  after_create :create_default_group


  private

    def setup_default_role_for_new_users
      if self.role.blank?
          self.role = "default"
      end
    end

    def create_default_group
      group = Group.new
      group.name = self.email.concat '-default'
      group.default_group = true
      if group.save
        self.groups << group
      else
        # ?????? group does not save so there's no default group
        raise
      end
      create_welcome_note(group)
    end

    def create_welcome_note(group)
      welcome_note = Note.new
      welcome_note.content = "Welcome to PYNDD! Share notes with your friends!"
      if welcome_note.save
        group.notes << welcome_note
      else
        ## oh well :(
      end
    end
end
