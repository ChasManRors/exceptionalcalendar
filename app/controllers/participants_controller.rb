class ParticipantsController < ApplicationController

  before_filter :find_participant, :only => [:show, :destroy, :edit, :update]
  before_filter :find_participants, :only => :index
  before_filter :new_participant, :only => [:new, :create]

  def setup_enclosing_resources
    @meeting = Meeting.find(params[:meeting_id])
  end
  def find_participant
    setup_enclosing_resources
    @participant = @meeting.participants.find(params[:id])
  end
  def find_participants
    setup_enclosing_resources
    @participants = @meeting.participants
  end
  def new_participant
    setup_enclosing_resources
    @participant = @meeting.participants.new(params[:participant])
  end

  # GET /participants
  # GET /participants.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @participants }
    end
  end

  # GET /participants/1
  # GET /participants/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.xml
  def create
    @meeting = @participant.meeting
    @all_tentative_days = @meeting.calc_tentative_days
    @previous_current_unavailable_days = @meeting.calc_current_unavailable_days
    @collection_of_unavailable_days = @participant.collection_of_unavailable_days.split
    @all_current_unavailable_days = @previous_current_unavailable_days + @collection_of_unavailable_days
    @tentative_days = @all_tentative_days - @all_current_unavailable_days 
    @participant.meeting.tentative_days = @tentative_days.join(' ')
    respond_to do |format|
      if @participant.save && @participant.meeting.save
        flash[:notice] = 'Participant  and meeting updates were successfully created.'
#        format.html { redirect_to(meeting_participants_path(@meeting)) }
        format.html { redirect_to(meeting_path(@meeting)) }
        format.xml  { render :xml => @participant, :status => :created, :location => @participant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.xml
  def update
    @meeting = @participant.meeting
    @calendar_subset = @meeting.calc_tentative_days
    @previous_current_unavailable_days = @meeting.calc_current_unavailable_days_sans(@participant)
#    @collection_of_unavailable_days = @participant.collection_of_unavailable_days.split
    @collection_of_unavailable_days = params[:participant][:collection_of_unavailable_days].split
    @all_current_unavailable_days = @previous_current_unavailable_days + @collection_of_unavailable_days
    @tentative_days = @calendar_subset - @all_current_unavailable_days 
    @participant.meeting.tentative_days = @tentative_days.join(' ')

    respond_to do |format|
      if @participant.update_attributes(params[:participant]) && @participant.meeting.save
        flash[:notice] = 'Participant was successfully updated.'
#        format.html { redirect_to(meeting_participant_path(@meeting, @participant)) }
        format.html { redirect_to(meeting_path(@meeting)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.xml
  def destroy
    @participant.destroy

    flash[:notice] = 'Participant was successfully removed.'
    respond_to do |format|
      format.html { redirect_to(meeting_participants_path(@meeting)) }
      format.xml  { head :ok }
    end
  end
end
