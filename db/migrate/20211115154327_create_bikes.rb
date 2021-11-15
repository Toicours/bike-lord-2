class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string :name
      t.text :description
      t.string :category
      t.boolean :available
      t.float :price
      t.string :user

      t.timestamps
    end
  end
end
