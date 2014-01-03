class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :description
      t.string :address

      t.timestamps
    end
    add_index :lists, [:address, :name], unique: true
  end
end
