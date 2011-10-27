class CreatePoiIcons < ActiveRecord::Migration
  def change
    create_table :poi_icons do |t|
      t.column :name, :string
      t.column :path, :string
      t.column :shadow, :string
      t.column :poi_category_id, :integer
      t.timestamps
    end
    add_column :pois, :poi_icon_id, :integer
  end
end
