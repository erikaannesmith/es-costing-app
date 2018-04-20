class AddLaborCostToStyles < ActiveRecord::Migration[5.1]
  def change
    add_column :styles, :labor_cost, :decimal
  end
end
