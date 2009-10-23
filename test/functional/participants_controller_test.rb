require File.dirname(__FILE__) + '/../test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  def setup
    @meeting = Meeting.find(:first)
    @participant = @meeting.participants.find(:first)
  end

  context "on GET to ParticipantsController#index" do
    setup do
      get :index, :meeting_id => @meeting.to_param
    end

    should_respond_with :success
    should_assign_to :participants
    should_render_template :index
    should_not_set_the_flash
    should_not_change "Participant.count"
  end

  context "on GET to ParticipantsController#show" do
    setup do
      get :show, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_assign_to :participant
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
    should_not_change "Participant.count"
    should "set @participant to requested instance" do
      assert_equal @participant, assigns(:participant)
    end
  end

  context "on GET to ParticipantsController#new" do
    setup do
      get :new, :meeting_id => @meeting.to_param
    end

    should_respond_with :success
    should_assign_to :participant
    should_not_set_the_flash
    should_render_template :new
    should_render_a_form
    should_not_change "Participant.count"
  end

  context "on GET to ParticipantsController#edit" do
    setup do
      get :edit, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_assign_to :participant
    should_respond_with :success

    should_render_template :edit
    should_not_set_the_flash
    should_render_a_form
    should_not_change "Participant.count"
    should "set @participant to requested instance" do
      assert_equal @participant, assigns(:participant)
    end
  end

  context "on POST to ParticipantsController#create with " do
    setup do
      post :create, :meeting_id => @meeting.to_param, :participant => {  }
    end

    should_assign_to :participant
    should_set_the_flash_to(/created/i)
    should_redirect_to "meeting_participants_path(@meeting)"
    should "not have errors on @participant" do 
      assert assigns(:participant).errors.blank?
    end
    should_change "Participant.count", :by => 1
  end

  context "on PUT to ParticipantsController#update with" do
    setup do
      put :update, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_assign_to :participant
    should_set_the_flash_to(/updated/i)
    should_redirect_to "meeting_participant_path(@meeting, @participant)"
    should_not_change "Participant.count"
    should "not have errors on @participant" do
      assert assigns(:participant).errors.empty?
    end
  end

  context "on DELETE to ParticipantsController#destroy" do
    setup do
      delete :destroy, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_set_the_flash_to(/removed/i)
    should_redirect_to "meeting_participants_path(@meeting)"
    should_change "Participant.count", :by => -1
  end

  context "on GET to ParticipantsController#index as xml" do
    setup do
      get :index, :meeting_id => @meeting.to_param, :format => "xml"
    end

    should_respond_with :success
    should_respond_with_content_type :xml #('participants') # TODO: fix this

    should_assign_to :participants
  end

  context "on GET to ParticipantsController#show as xml" do
    setup do
      get :show, :id => @participant.to_param, :meeting_id => @meeting.to_param, :format => "xml"
    end

    should_assign_to :participant
    should_respond_with :success

#    should_respond_with_xml_for('participant') # TODO: fix this
  end

  context "on POST to ParticipantsController#create as xml" do
    setup do
      post :create, :meeting_id => @meeting.to_param, :participant => {  }
    end

    should_assign_to :participant
    should "not have errors on @participant" do 
      assert assigns(:participant).errors.blank?
    end
  end

  context "on PUT to ParticipantsController#update as xml" do
    setup do
      put :update, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_assign_to :participant
    should "not have errors on @participant" do
      assert assigns(:participant).errors.blank?
    end
  end

  context "on DELETE to ParticipantsController#destroy as xml" do
    setup do
      delete :destroy, :id => @participant.to_param, :meeting_id => @meeting.to_param
    end

    should_change "Participant.count", :by => -1
  end
end
