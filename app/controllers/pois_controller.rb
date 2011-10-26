class PoisController < ApplicationController
  respond_to :html, :xml, :json, :js, :zip

  def index
    @markers = Poi.all
    respond_with(@markers) do |format|
      format.zip {
        zipfile = Zippy.create '/tmp/pois.zip' do |zip|
          @markers.each do |m|
            if m.image?
              Rails.logger.warn ">>> zipping #{m.image.path(:app)}"
              zip[m.image_file_name] = File.open(m.image.path(:app))
            end
          end
        end
        send_file('/tmp/pois.zip')
      }
    end
  end
  
  def show
    @poi ||= Poi.find(params[:id])
    respond_with(@poi)
  end

  def new
    respond_with(@poi = Poi.new)
  end

  def create
    @poi = Poi.create(params[:poi])
    respond_with(@poi) do |format|
      format.html { redirect_to :action => :index }
      format.js { redirect_to :action => :show, :id => @poi.id}
    end
  end

  def edit
    respond_with(@poi = Poi.find(params[:id]))
  end

  def update
    @poi = Poi.find(params[:id])
    @poi.update_attributes(params[:poi])
    respond_with(@poi) do |format|
      format.html { redirect_to :action => :index }
      format.js { redirect_to :action => :show }
    end
  end

end
