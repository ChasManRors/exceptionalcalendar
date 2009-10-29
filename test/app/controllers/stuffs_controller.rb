class StuffsController < ApplicationController
  # GET /stuffs
  # GET /stuffs.xml
  def index
    @stuffs = Stuff.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stuffs }
    end
  end

  # GET /stuffs/1
  # GET /stuffs/1.xml
  def show
    @stuff = Stuff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stuff }
    end
  end

  # GET /stuffs/new
  # GET /stuffs/new.xml
  def new
    @stuff = Stuff.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stuff }
    end
  end

  # GET /stuffs/1/edit
  def edit
    @stuff = Stuff.find(params[:id])
  end

  # POST /stuffs
  # POST /stuffs.xml
  def create
    @stuff = Stuff.new(params[:stuff])

    respond_to do |format|
      if @stuff.save
        flash[:notice] = 'Stuff was successfully created.'
        format.html { redirect_to(@stuff) }
        format.xml  { render :xml => @stuff, :status => :created, :location => @stuff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stuff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stuffs/1
  # PUT /stuffs/1.xml
  def update
    @stuff = Stuff.find(params[:id])

    respond_to do |format|
      if @stuff.update_attributes(params[:stuff])
        flash[:notice] = 'Stuff was successfully updated.'
        format.html { redirect_to(@stuff) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stuff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.xml
  def destroy
    @stuff = Stuff.find(params[:id])
    @stuff.destroy

    respond_to do |format|
      format.html { redirect_to(stuffs_url) }
      format.xml  { head :ok }
    end
  end
end
