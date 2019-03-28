require 'test_helper'

class AccessControlsControllerTest < ActionController::TestCase
  setup do
    @access_control = access_controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_controls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create access_control" do
    assert_difference('AccessControl.count') do
      post :create, access_control: { ability_to_comment: @access_control.ability_to_comment, ability_to_create_answer: @access_control.ability_to_create_answer, ability_to_create_discussion: @access_control.ability_to_create_discussion, ability_to_create_question: @access_control.ability_to_create_question, ability_to_create_stream: @access_control.ability_to_create_stream, role_id: @access_control.role_id, uuid: @access_control.uuid }
    end

    assert_redirected_to access_control_path(assigns(:access_control))
  end

  test "should show access_control" do
    get :show, id: @access_control
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @access_control
    assert_response :success
  end

  test "should update access_control" do
    patch :update, id: @access_control, access_control: { ability_to_comment: @access_control.ability_to_comment, ability_to_create_answer: @access_control.ability_to_create_answer, ability_to_create_discussion: @access_control.ability_to_create_discussion, ability_to_create_question: @access_control.ability_to_create_question, ability_to_create_stream: @access_control.ability_to_create_stream, role_id: @access_control.role_id, uuid: @access_control.uuid }
    assert_redirected_to access_control_path(assigns(:access_control))
  end

  test "should destroy access_control" do
    assert_difference('AccessControl.count', -1) do
      delete :destroy, id: @access_control
    end

    assert_redirected_to access_controls_path
  end
end
