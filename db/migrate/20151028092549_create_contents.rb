class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :description
      t.string :title
      t.references :user, index: true, foreign_key: true
      t.string :image_src

      t.timestamps null: false
    end
  end
end
