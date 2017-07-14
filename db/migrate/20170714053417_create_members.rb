class CreateMembers < ActiveRecord::Migration[5.1]
  def up
    create_table :members do |t|
      t.string :name
      t.string :email, index: true
      t.decimal :balance, default: 100.00, precision: 30, scale: 2, index: true

      t.timestamps
    end unless table_exists?(:members)
  end

  def down
    drop_table :members if table_exists?(:members)
  end
end
