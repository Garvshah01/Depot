class ChangeLineItemsCountInCart < ActiveRecord::Migration[7.0]
  def change
    change_column_default :carts, :line_items_count, from: nil, to: 0
  end
end
