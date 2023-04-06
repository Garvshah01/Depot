class IrreversableMigrationExample < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.boolean :is_public
    end
    change_column_default :articles, :is_public, true
  end
end
