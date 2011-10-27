class Poi < ActiveRecord::Base
  belongs_to :poi_set
  belongs_to :poi_icon
  default_scope :order => 'name ASC'
  
  has_attached_file :image, :styles => {:icon => '36x24#', :app => '640x427#', :test => '320x213#'}

  def cat
    poi_icon.poi_category.name if poi_icon
  end
  
  def icon
    poi_icon.name if poi_icon
  end
  
  def as_json(options={})
    basis = {
      :id => id,
      :name => name,
      :description => description,
      :address => address,
      :lat => lat,
      :lng => lng,
      :icon => icon,
      :cat => cat,
      :url => url
    }
    basis[:image] = image.url(:test) if image?
    basis
  end
  
end
