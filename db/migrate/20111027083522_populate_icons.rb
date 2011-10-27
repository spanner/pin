class PopulateIcons < ActiveRecord::Migration
  def up
    Poi.reset_column_information
    PoiCategory.all.each do |pc|
      if pc.pois.any?
        pi = PoiIcon.create! :name => pc.name, :path => pc.icon, :shadow => pc.shadow, :poi_category => pc
        pc.pois.each do |poi|
          poi.update_attribute :poi_icon, pi
        end
      end
    end
  end

  def down
  end
end
