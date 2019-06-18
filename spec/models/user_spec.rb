require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email, password" do
    user = User.new(
      name: "Taro yamada",
      email: "taroyamada@example.com",
      password: "123456789"
    )
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(
      name: nil
    )
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(
      email: nil
    )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "does not have a duplicate email" do
    user = User.create(
      name: "Taro yamada",
      email: "taroyamada@example.com",
      password: "123456789"
    )
    dup_user = User.new(
      name: "Jiro Tanaka",
      email: "taroyamada@example.com",
      password: "jiroyamada1111"
    )
    dup_user.valid?
    expect(dup_user.errors[:email]).to include("has already been taken")

  end
end
