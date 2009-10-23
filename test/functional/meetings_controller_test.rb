require File.dirname(__FILE__) + '/../test_helper'

class MeetingsControllerTest < ActionController::TestCase
  def setup
    @meeting = Meeting.find(:first)
  end

  context "on GET to MeetingsController#index" do
    setup do
      get :index
    end

    should_respond_with :success
    should_assign_to :meetings
    should_render_template :index
    should_not_set_the_flash
    should_not_change "Meeting.count"
  end

  context "on GET to MeetingsController#show" do
    setup do
      get :show, :id => @meeting.to_param
    end

    should_assign_to :meeting
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
    should_not_change "Meeting.count"
    should "set @meeting to requested instance" do
      assert_equal @meeting, assigns(:meeting)
    end
  end

  context "on GET to MeetingsController#new" do
    setup do
      get :new
    end

    should_respond_with :success
    should_assign_to :meeting
    should_not_set_the_flash
    should_render_template :new
    should_render_a_form
    should_not_change "Meeting.count"
  end

  context "on GET to MeetingsController#edit" do
    setup do
      get :edit, :id => @meeting.to_param
    end

    should_assign_to :meeting
    should_respond_with :success

    should_render_template :edit
    should_not_set_the_flash
    should_render_a_form
    should_not_change "Meeting.count"
    should "set @meeting to requested instance" do
      assert_equal @meeting, assigns(:meeting)
    end
  end

  context "on POST to MeetingsController#create with " do
    setup do
      post :create, :meeting => {  }
    end

    should_assign_to :meeting
    should_set_the_flash_to(/created/i)
    should_redirect_to "meetings_path()"
    should "not have errors on @meeting" do 
      assert assigns(:meeting).errors.blank?
    end
    should_change "Meeting.count", :by => 1
  end

  context "on PUT to MeetingsController#update with" do
    setup do
      put :update, :id => @meeting.to_param
    end

    should_assign_to :meeting
    should_set_the_flash_to(/updated/i)
    should_redirect_to "meeting_path(@meeting)"
    should_not_change "Meeting.count"
    should "not have errors on @meeting" do
      assert assigns(:meeting).errors.empty?
    end
  end

  context "on DELETE to MeetingsController#destroy" do
    setup do
      delete :destroy, :id => @meeting.to_param
    end

    should_set_the_flash_to(/removed/i)
    should_redirect_to "meetings_path()"
    should_change "Meeting.count", :by => -1
  end

  context "on GET to MeetingsController#index as xml" do
    setup do
      get :index, :format => "xml"
    end

    should_respond_with :success
    should_respond_with_content_type :xml #('meetings') # TODO: fix this

    should_assign_to :meetings
  end

  context "on GET to MeetingsController#show as xml" do
    setup do
      get :show, :id => @meeting.to_param, :format => "xml"
    end

    should_assign_to :meeting
    should_respond_with :success

#    should_respond_with_xml_for('meeting') # TODO: fix this
  end

  context "on POST to MeetingsController#create as xml" do
    setup do
      post :create, :meeting => {  }
    end

    should_assign_to :meeting
    should "not have errors on @meeting" do 
      assert assigns(:meeting).errors.blank?
    end
  end

  context "on PUT to MeetingsController#update as xml" do
    setup do
      put :update, :id => @meeting.to_param
    end

    should_assign_to :meeting
    should "not have errors on @meeting" do
      assert assigns(:meeting).errors.blank?
    end
  end

  context "on DELETE to MeetingsController#destroy as xml" do
    setup do
      delete :destroy, :id => @meeting.to_param
    end

    should_change "Meeting.count", :by => -1
  end
end
