class AddColumnToBikes < ActiveRecord::Migration[6.0]
  def change
    add_column :bikes, :address, :string
  end
end
