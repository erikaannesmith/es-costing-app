class CreateStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :styles do |t|
      t.string :name
      t.integer :amount
      t.decimal :cost
      t.string :season
      t.references :client, foreign_key: true
    end
  end
end
