class Note < ActiveRecord::Base
  belongs_to :group

  delegate :users, to: :group

  validates :content, presence: true
end
