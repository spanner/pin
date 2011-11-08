class CreatePolylines < ActiveRecord::Migration
  def change
    create_table :polylines do |t|
      t.column :name, :string
      t.column :user_id, :integer
      t.timestamps
    end
    create_table :line_points do |t|
      t.column :polyline_id, :integer
      t.column :poi_id, :integer
      t.timestamps
    end
  end
end
