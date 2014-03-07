class Note < ActiveRecord::Base
  belongs_to :group

  delegate :users, to: :group

  validates :content, presence: true, length: 1..140

  after_create :send_create_note_text

  def my_note?
    self.group.default_group?
  end

  def send_create_note_text(current_user = nil)
    if current_user && TextNotification.send_texts
      TextNotification.new(message: "Hi, #{current_user.email} added '#{self.content}' to #{self.group.name}",
        group: self.group, created_by: current_user).send_text
    end
  end

  def send_complete_note_text(current_user = nil)
    if current_user && check && TextNotification.send_texts
      TextNotification.new(message: "Hi, #{current_user.email} marked '#{self.content}' in #{self.group.name} as complete",
        group: self.group, created_by: current_user).send_text
    end
  end
end
