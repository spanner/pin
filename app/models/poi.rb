require 'geokit'

class Poi < ActiveRecord::Base
  belongs_to :poi_category
  belongs_to :poi_set
  
  # accepts_nested_attributes_for :poi_category
  
  has_attached_file :image, :styles => {:icon => '36x24#', :app => '640x427#', :test => '320x213#'}

  def cat
    poi_category.name if poi_category
  end
  
  def icon
    poi_category.icon if poi_category
  end
  
  def as_json(options={})
    basis = {
      :id => id,
      :name => name,
      :description => description,
      :address => address,
      :lat => lat,
      :lng => lng,
      :cat => cat,
      :url => url
    }
    basis[:image] = image.url(:test) if image?
    basis
  end
  
end
