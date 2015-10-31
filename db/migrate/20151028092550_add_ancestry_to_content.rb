class AddAncestryToContent < ActiveRecord::Migration
  def change
    add_column :contents, :ancestry, :string
    add_index :contents, :ancestry
  end
end
