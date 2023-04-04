class AddColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :enabled, :boolean
    add_column :users, :discount_price, :decimal, default:0
    add_column :users, :permalink, :string
  end
end
