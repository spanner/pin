class PoiCategoriesController < ApplicationController
  # GET /poi_categories
  # GET /poi_categories.json
  def index
    @poi_categories = PoiCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @poi_categories }
    end
  end

  # GET /poi_categories/1
  # GET /poi_categories/1.json
  def show
    @poi_category = PoiCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @poi_category }
    end
  end

  # GET /poi_categories/new
  # GET /poi_categories/new.json
  def new
    @poi_category = PoiCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @poi_category }
    end
  end

  # GET /poi_categories/1/edit
  def edit
    @poi_category = PoiCategory.find(params[:id])
  end

  # POST /poi_categories
  # POST /poi_categories.json
  def create
    @poi_category = PoiCategory.new(params[:poi_category])

    respond_to do |format|
      if @poi_category.save
        format.html { redirect_to @poi_category, :notice => 'Poi category was successfully created.' }
        format.json { render :json => @poi_category, :status => :created, :location => @poi_category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @poi_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poi_categories/1
  # PUT /poi_categories/1.json
  def update
    @poi_category = PoiCategory.find(params[:id])

    respond_to do |format|
      if @poi_category.update_attributes(params[:poi_category])
        format.html { redirect_to @poi_category, :notice => 'Poi category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @poi_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poi_categories/1
  # DELETE /poi_categories/1.json
  def destroy
    @poi_category = PoiCategory.find(params[:id])
    @poi_category.destroy

    respond_to do |format|
      format.html { redirect_to poi_categories_url }
      format.json { head :ok }
    end
  end
end
