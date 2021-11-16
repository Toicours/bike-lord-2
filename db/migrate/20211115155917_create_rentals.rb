class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.float :total_price
      t.integer :user_id
      t.integer :bike_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
