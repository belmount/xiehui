require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { address: @member.address, contract: @member.contract, contract_tel: @member.contract_tel, legal_person: @member.legal_person, legal_tel: @member.legal_tel, logo_url: @member.logo_url, name: @member.name, tel: @member.tel, type: @member.type, url: @member.url }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member, member: { address: @member.address, contract: @member.contract, contract_tel: @member.contract_tel, legal_person: @member.legal_person, legal_tel: @member.legal_tel, logo_url: @member.logo_url, name: @member.name, tel: @member.tel, type: @member.type, url: @member.url }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end