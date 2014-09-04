class CreateTempData < ActiveRecord::Migration
  def change
    create_table :temp_data do |t|

      t.timestamps
    end
  end
end
