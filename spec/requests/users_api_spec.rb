require 'rails_helper'

RSpec.describe "UsersApi", type: :request do
  it "registers a user" do
    user_params = FactoryBot.attributes_for(:user)
    # check if the data registered
    expect {
    post user_registration_path, params: user_params
    }.to change(User, :count).by(1)
    # check the response http status
    expect(response).to have_http_status "200"
#   puts "response.body.class: #{response.body.class}"
#   puts "response.inspect: #{response.inspect}"
#   puts "response.body #{response.body}"
    # check the registered data
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    expect(data[:name]).to eq user_params[:name]
    expect(data[:email]).to eq user_params[:email]
  end

  it "deletes a user" do
    user_params = FactoryBot.attributes_for(:user)
    # 1. sign-up
    expect {
    post user_registration_path, params: user_params
    }.to change(User, :count).by(1)
    saved_user = User.last
#   puts "saved_user: #{saved_user.inspect}"
#   puts "request json: #{JSON.parse(response, symbolize_names: true)}"
    # 2.sign-in automatically
#   sign_in saved_user
#   puts "body(json): #{JSON.parse(response.body, symbolize_names: true)}"
#   puts "body class: #{response.body}"
#   puts "header: #{response.headers.inspect}"
#   puts "headers class: #{response.headers.class}"

    auth_params = get_auth_params_from_login_response_headers(response)

    # 3. delete a user
    aggregate_failures do
      expect {
        delete user_registration_path(saved_user), headers: auth_params
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status "200"
    end
  end

  it "edits a user" do
    params = {email: "edit@example.com", password: "edit_password_123"}
    saved_user = FactoryBot.create(:user, params)
    # sing-in
    post user_session_path, params: params
    expect(response).to have_http_status "200"

    auth_params = get_auth_params_from_login_response_headers(response)
    # edit a user
    editted_params = { email: "editted@example.com" }
    patch user_registration_path, headers: auth_params, params: editted_params
#   puts "response: #{response.body}"
    expect(response).to have_http_status "200"
    expect(saved_user.reload.email).to eq "editted@example.com"
  end
  it "shows a user account"
  it "makes it possible for a user to sign in and sign out" do
    params = { email: "login@example.com", password: "login_test_123"}
    saved_user = FactoryBot.create(:user, params)
    post user_session_path, params: params
#   puts "response.headers: #{response.headers.inspect}"
#   puts "body(json): #{JSON.parse(response.body, symbolize_names: true)}"
    aggregate_failures do
      expect(response).to have_http_status "200"
      expect(response.has_header?('access-token')).to eq(true)
      expect(response.has_header?('token-type')).to eq(true)
      expect(response.has_header?('client')).to eq(true)
      expect(response.has_header?('uid')).to eq(true)
    end
    auth_params = get_auth_params_from_login_response_headers(response)

    # sign-out
    delete destroy_user_session_path, headers: auth_params
    aggregate_failures do
      expect(response).to have_http_status "200"
      expect(response.has_header?('access-token')).to eq(false)
      expect(response.has_header?('token-type')).to eq(false)
      expect(response.has_header?('client')).to eq(false)
      expect(response.has_header?('uid')).to eq(false)
    end

  end

  it "makes it possible for a user to change their passowrd" do
    user_param = {email: "change_password@example.com", password: "change_password_12345"}
    saved_user = FactoryBot.create(:user, user_param)

    #login
    post user_session_path, params: user_param
    expect(response).to have_http_status "200"
    auth_params = get_auth_params_from_login_response_headers(response)

    #change password
    saved_encrypted_cpassword = saved_user.encrypted_password
    changed_password = "changed_password"
    patch user_password_path, params: { password: changed_password, password_confirmation: changed_password}, headers: auth_params
    aggregate_failures do
      expect(response).to have_http_status "200"
      expect(saved_user.reload.encrypted_password).to_not eq saved_encrypted_cpassword
    end
  end

  # ref: https://devise-token-auth.gitbook.io/devise-token-auth/usage/testing
	def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
    auth_params
  end

end
