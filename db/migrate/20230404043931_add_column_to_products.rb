class AddColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :enabled, :boolean
    add_column :products, :discount_price, :decimal, default: 0
    add_column :products, :permalink, :string
  end
end
