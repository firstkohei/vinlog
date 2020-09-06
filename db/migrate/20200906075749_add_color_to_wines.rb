class AddColorToWines < ActiveRecord::Migration[5.2]
  def change
    add_column :wines, :color, :string
  end
end
