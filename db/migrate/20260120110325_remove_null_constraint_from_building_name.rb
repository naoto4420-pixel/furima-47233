class RemoveNullConstraintFromBuildingName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :shipping_addresses, :building_name, true
  end
end
