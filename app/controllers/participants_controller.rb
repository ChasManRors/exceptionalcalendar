class ParticipantsController < ApplicationController

  before_filter :find_participant, :only => [:show, :destroy, :edit, :update]
  before_filter :find_participants, :only => :index
  before_filter :new_participant, :only => [:new, :create]
  before_filter :update_participant_params, :only => [:update]

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
    passed_in_available_days = params[:participant][:available_days]
    if passed_in_available_days.blank?
      unavailable_days = (params[:participant][:collection_of_unavailable_days]).split
    else
      available_array = passed_in_available_days.split
      unavailable_days = @meeting.calc_tentative_days -  available_array
    end
    @participant = Participant.new
    @participant.name = params[:participant][:name]
    @participant.meeting_id = @meeting.id
    @participant.collection_of_unavailable_days = unavailable_days.join(' ')
    # @meeting.participants << @participant
  end

# TODO push down into the model
  def update_participant_params
    setup_enclosing_resources
    passed_in_available_days = params[:participant][:available_days]
    if passed_in_available_days.blank?
      unavailable_days = (params[:participant][:collection_of_unavailable_days]).split
    else
      available_array = passed_in_available_days.split
      unavailable_days = @meeting.calc_tentative_days - available_array
    end
    params[:participant].delete(:available_days)
    params[:participant][:collection_of_unavailable_days] = unavailable_days.join(' ')
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
    @meeting.add_new_participant(@participant)
    respond_to do |format|
      if @participant.save && @meeting.save
        flash[:notice] = 'Participant  and meeting updates were successfully created.'
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
    respond_to do |format|
     if @participant.update_attributes(params[:participant]) && @meeting.update_attributes(@meeting.new_meeting_params_from(@participant, params[:participant]))
        flash[:notice] = 'Participant was successfully updated.'
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
