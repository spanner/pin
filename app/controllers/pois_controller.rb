class PoisController < ApplicationController
  respond_to :html, :xml, :json, :js, :zip
  # before_filter :check_create_permission, :only => [:new, :create, :destroy]
  # before_filter :check_edit_permission, :only => [:edit, :update]
  before_filter :default_to_guest_user

  load_resource :except => [:index, :create, :update]

  def index
    @markers = current_user.pois
    @markers = @markers.in_set(@set) if @set
    
    respond_with(@markers) do |format|
      format.zip {
        zipfile = Zippy.create '/tmp/pois.zip' do |zip|
          @markers.each do |m|
            zip[m.image_file_name] = File.open(m.image.path(:app)) if m.image?
          end
        end
        send_file('/tmp/pois.zip')
      }
    end
  end

  def create
    @poi = Poi.create(params[:poi])
    respond_with(@poi) do |format|
      format.html { redirect_to :action => :index }
      format.js { redirect_to @poi }
    end
  end

  def update
    @poi = Poi.find(params[:id])
    @poi.update_attributes(params[:poi])
    respond_with(@poi) do |format|
      format.html { redirect_to :action => :index }
      format.js { redirect_to @poi }
    end
  end




protected
  def get_set
    @set = PoiSet.find_by_id(params[:poi_set_id])
    # authorize! :read, @set
  end
  
  def check_create_permission
    authorize! :create, resource
  end

  def check_edit_permission
    authorize! :edit, resource
  end

end
