require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quizzes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz" do
    assert_difference('Quiz.count') do
      post :create, :quiz => { }
    end

    assert_redirected_to quiz_path(assigns(:quiz))
  end

  test "should show quiz" do
    get :show, :id => quizzes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quizzes(:one).to_param
    assert_response :success
  end

  test "should update quiz" do
    put :update, :id => quizzes(:one).to_param, :quiz => {:status => 'active' }
    assert_redirected_to quiz_path(assigns(:quiz))
  end

  test "should destroy quiz" do
    assert_difference('Quiz.count', -1) do
      delete :destroy, :id => quizzes(:one).to_param
    end

    assert_redirected_to quizzes_path
  end
end
