class DeleteLineItemCounterFromCart < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :line_item_count, :integer
  end
end
