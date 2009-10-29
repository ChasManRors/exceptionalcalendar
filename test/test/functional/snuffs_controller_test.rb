require File.dirname(__FILE__) + '/../test_helper'
require 'snuffs_controller'

# Re-raise errors caught by the controller.
class SnuffsController; def rescue_action(e) raise e end; end

class SnuffsControllerTest < Test::Unit::TestCase
  fixtures :snuffs

  def setup
    @controller = SnuffsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show
    get :show
    assert_response :success
    assert_template 'show'
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:snuffs)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:snuff)
    assert assigns(:snuff).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:snuff)
  end

  def test_create
    num_snuffs = Snuff.count

    post :create, :snuff => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_snuffs + 1, Snuff.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:snuff)
    assert assigns(:snuff).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Snuff.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Snuff.find(1)
    }
  end
end
