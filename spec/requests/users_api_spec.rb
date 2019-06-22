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
    # to delete a user, steps below are necessary:
    # 1. sign-up
    # 2. sign-in
    # 3. delete a user
    user_params = FactoryBot.attributes_for(:user)
    # 1. sign-up
    expect {
    post user_registration_path, params: user_params
    }.to change(User, :count).by(1)
    saved_user = User.last
#   puts "saved_user: #{saved_user.inspect}"
#   puts "request json: #{JSON.parse(response, symbolize_names: true)}"
    # 2.sign-in by helper method (./support/request_spec_helper.rb)
    sign_in saved_user

#   puts "body(json): #{JSON.parse(response.body, symbolize_names: true)}"
#   puts "body class: #{request.body}"
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
  it "edits a user"
  it "shows a user account"
  it "makes it possible for a user to sign in"
  it "makes it possible for a user to sign oout"
  it "makes is possible for a user to change their passowrd"

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
