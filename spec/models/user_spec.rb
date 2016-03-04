require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password")}

  #Shoulda tests for name
  it { expect(user).to validate_presence_of(:name)}
  it { expect(user).to validate_length_of(:name).is_at_least(1)}


  #Shoulda tests for email
  it { expect(user).to validate_presence_of(:email)}
  it { expect(user).to validate_uniqueness_of(:email)}
  it { expect(user).to validate_length_of(:email).is_at_least(3)}
  it { expect(user).to allow_value("user@bloccit").for(:email)}

  #Shoulda tests for password
#  it { expect(user).to validate_presence_of(:password)}
#  it { expect(user).to have_secure_password}
#  it { expect(user).to validate_length_of(:password).is_at_least(6)}
#=========================================================================
  describe "attributes" do

    it "should respond to name" do
      expect(user).to respond_to(:name)
    end

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "should capitalize the first and last name" do
      user.name = "john doe"
      user.save

      expect(user.name).to eq("John Doe")
    end

  end
#=========================================================================
  describe "invalid user" do

    let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com")}
    let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "")}

    it "should be an invalid user due to a blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to a blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

  end
#=========================================================================

#  describe "creating a user" do

#    let(:lowercase_name_user) {User.new(name: "john doe", email: "user@bloccit.com", password: "password")}

#    it "capitalizes the first and last name" do
#      lowercase_name_user.name = capitalize_first_last(lowercase_name_user.name)

#      expect(lowercase_name_user.name).to eq("John Doe")
      #expect(lowercase_name_user.name).to be_valid
#    end

#  end

#=========================================================================

#Methods
  def capitalize_first_last(name)
    name = name.split.map!{ |cap| cap.capitalize }.join(" ")
  end
end
