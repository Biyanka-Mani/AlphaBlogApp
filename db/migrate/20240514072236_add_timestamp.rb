class AddTimestamp < ActiveRecord::Migration[7.1]
  def change
    add_column :articles,:starting, :datetime 
    add_column :articles,:ending,:datetime
  end
end
