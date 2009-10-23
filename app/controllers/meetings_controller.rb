class MeetingsController < ApplicationController

  before_filter :find_meeting, :only => [:show, :destroy, :edit, :update]
  before_filter :find_meetings, :only => :index
  before_filter :new_meeting, :only => [:new, :create]

  def setup_enclosing_resources

  end
  def find_meeting
    setup_enclosing_resources
    @meeting = Meeting.find(params[:id])
    @participant = @meeting.participants.new(params[:participant])
  end
  def find_meetings
    setup_enclosing_resources
    @meetings = Meeting.paginate :per_page => 1, :page => params[:page], :order => 'created_at DESC'
    #@meetings = Meeting.find(:all).reverse
  end
  def new_meeting
    setup_enclosing_resources
    @meeting = Meeting.new(params[:meeting])
  end

  # GET /meetings
  # GET /meetings.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meetings }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.xml
  def create

    @initial_days = @meeting.calc_tentative_days()
#    @meeting.tentative_days =  @initial_days.join(" ")

    respond_to do |format|
      if @meeting.save
        flash[:notice] = 'Meeting was successfully created.'
        format.html { redirect_to(meetings_path()) }
        format.xml  { render :xml => @meeting, :status => :created, :location => @meeting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.xml
  def update
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        flash[:notice] = 'Meeting was successfully updated.'
        format.html { redirect_to(meeting_path(@meeting)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.xml
  def destroy
    @meeting.destroy

    flash[:notice] = 'Meeting was successfully removed.'
    respond_to do |format|
      format.html { redirect_to(meetings_path()) }
      format.xml  { head :ok }
    end
  end
end
