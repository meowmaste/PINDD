class AddCheckToNote < ActiveRecord::Migration
  def change
    add_column :notes, :check, :boolean
  end
end
