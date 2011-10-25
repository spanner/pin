class PoisController < ApplicationController
  respond_to :html, :xml, :json, :js, :csv

  def index
    @markers = Poi.all
    respond_with(@markers)
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
