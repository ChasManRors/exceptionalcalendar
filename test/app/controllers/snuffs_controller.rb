class SnuffsController < ApplicationController
	paginate :snuffs, :per_page => 10
  def index
  end

  def show
  end

  def list
		render :partial => 'list'
  end

  def show
    @snuff = Snuff.find(params[:id])
		render :partial =>'item'
  end

  def new
    @snuff = Snuff.new
		render :partial => 'new'
  end

  def create
    @snuff = Snuff.new(params[:snuff])
    if @snuff.save
			list
    else
      render :partial => 'new'
    end
  end

  def edit
    @snuff = Snuff.find(params[:id])
		render :partial => 'edit'
  end

  def update
    @snuff = Snuff.find(params[:id])
    if @snuff.update_attributes(params[:snuff])
      render :partial => 'item'
    else
      render :partial => 'edit'
    end
  end

  def destroy
    Snuff.find(params[:id]).destroy
		render :nothing => true
  end
end
