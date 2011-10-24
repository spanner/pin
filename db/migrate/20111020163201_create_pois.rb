class CreatePois < ActiveRecord::Migration
  def change
    create_table :pois do |t|
      t.column :name, :string
      t.column :lat, :decimal, :precision => 15, :scale => 10
      t.column :lng, :decimal, :precision => 15, :scale => 10
      t.column :address, :text,
      t.column :poi_category_id, :integer
      t.column :poi_set_id, :integer
      t.timestamps
    end
  end
end
