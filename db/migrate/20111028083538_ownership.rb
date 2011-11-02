class Ownership < ActiveRecord::Migration
  def up
    [:pois, :poi_categories, :poi_icons, :poi_sets].each do |table|
      add_column table, :user_id, :integer
    end
  end

  def down
    [:pois, :poi_categories, :poi_icons, :poi_sets].each do |table|
      remove_column table, :user_id
    end
  end
end
