class AddPriceToContent < ActiveRecord::Migration
  def change
    add_column :contents, :price, :decimal
  end
end
