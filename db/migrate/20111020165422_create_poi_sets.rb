class CreatePoiSets < ActiveRecord::Migration
  def change
    create_table :poi_sets do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
