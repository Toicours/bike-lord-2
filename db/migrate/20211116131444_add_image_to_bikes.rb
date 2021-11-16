class AddImageToBikes < ActiveRecord::Migration[6.0]
  def change
    add_column :bikes, :image, :string
  end
end
