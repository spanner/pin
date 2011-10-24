class PoisController < ApplicationController
  respond_to :html, :xml, :json, :js

  def index
    @markers = Poi.all
    respond_with(@markers)
  end
  
  def show
    respond_with(@poi = Poi.find(params[:id]))
  end

  def new
    respond_with(@poi = Poi.new)
  end

  def create
    respond_with(@poi = Poi.create(params[:poi]))
  end

  def edit
    respond_with(@poi = Poi.find(params[:id]))
  end

  def update
    @poi = Poi.find(params[:id])
    @poi.update_attributes(params[:poi])
    redirect_to :action => :show
  end

end
