class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.string :image
      t.text :content
      t.string :name

      t.timestamps
    end
  end
end
