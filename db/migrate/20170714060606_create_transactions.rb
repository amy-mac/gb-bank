class CreateTransactions < ActiveRecord::Migration[5.1]
  def up
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount, precision: 30, scale: 2
      t.datetime :date
      t.references :member, index: true

      t.timestamps
    end unless table_exists?(:transactions)
  end

  def down
    drop_table :transactions if table_exists?(:transactions)
  end
end
