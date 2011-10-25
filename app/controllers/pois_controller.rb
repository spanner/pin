class PoisController < ApplicationController
  respond_to :html, :xml, :json, :js

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
    Rails.logger.warn "created! @poi is #{@poi}"
    redirect_to :action => :show, :id => @poi.id
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
