require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email, password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "does not have a duplicate email" do
    user = FactoryBot.create(:user)
    dup_user = FactoryBot.build(:user, email: user.email)
    dup_user.valid?
    expect(dup_user.errors[:email]).to include("has already been taken")
  end

  it "is valid with the same user name unless they have differenct email address" do
    user = FactoryBot.create(:user)
    dup_user = FactoryBot.build(:user)
    expect(dup_user).to be_valid
  end
end
