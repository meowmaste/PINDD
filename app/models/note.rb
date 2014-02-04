class Note < ActiveRecord::Base
  belongs_to :group

  delegate :users, to: :group
end
