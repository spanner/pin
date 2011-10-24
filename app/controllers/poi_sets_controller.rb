class PoiSetsController < ApplicationController
  # GET /poi_sets
  # GET /poi_sets.json
  def index
    @poi_sets = PoiSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @poi_sets }
    end
  end

  # GET /poi_sets/1
  # GET /poi_sets/1.json
  def show
    @poi_set = PoiSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @poi_set }
    end
  end

  # GET /poi_sets/new
  # GET /poi_sets/new.json
  def new
    @poi_set = PoiSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @poi_set }
    end
  end

  # GET /poi_sets/1/edit
  def edit
    @poi_set = PoiSet.find(params[:id])
  end

  # POST /poi_sets
  # POST /poi_sets.json
  def create
    @poi_set = PoiSet.new(params[:poi_set])

    respond_to do |format|
      if @poi_set.save
        format.html { redirect_to @poi_set, :notice => 'Poi set was successfully created.' }
        format.json { render :json => @poi_set, :status => :created, :location => @poi_set }
      else
        format.html { render :action => "new" }
        format.json { render :json => @poi_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poi_sets/1
  # PUT /poi_sets/1.json
  def update
    @poi_set = PoiSet.find(params[:id])

    respond_to do |format|
      if @poi_set.update_attributes(params[:poi_set])
        format.html { redirect_to @poi_set, :notice => 'Poi set was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @poi_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_sets/1
  # DELETE /poi_sets/1.json
  def destroy
    @poi_set = PoiSet.find(params[:id])
    @poi_set.destroy

    respond_to do |format|
      format.html { redirect_to poi_sets_url }
      format.json { head :ok }
    end
  end
end
