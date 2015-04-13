require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    #@user = users(:zack)
    @user = User.new(name: "Example User", email: "user@example.com", zip: "77706", 
            password: "foobar1", password_confirmation: "foobar1", id: "1")
  end

 
  test "unsuccessful edit" do
    get edit_user_path(@user)
    #assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_not flash.empty?
  end

   test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    #assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    @user.reload
    assert_redirected_to login_url
    assert_equal @user.name,  name
    assert_equal @user.email, email
   end

   test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
   end

   test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
   end
 end
