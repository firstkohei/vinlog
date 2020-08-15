class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :content
      t.string :area
      t.string :taste
      t.string :grape
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
