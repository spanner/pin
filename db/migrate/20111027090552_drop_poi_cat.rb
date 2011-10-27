class DropPoiCat < ActiveRecord::Migration
  def up
    remove_column :pois, :poi_category_id
    remove_column :poi_categories, :icon
    remove_column :poi_categories, :shadow
  end

  def down
    add_column :pois, :poi_category_id, :integer
    add_column :poi_categories, :icon, :string
    add_column :poi_categories, :shadow, :string
  end
end
