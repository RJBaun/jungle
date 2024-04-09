require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do 
    it "should allow a valid user to be created" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "vp@example.com", password: "test123", password_confirmation: "test123")
      expect { user.save! }.to_not raise_error
      expect(user.errors.full_messages).to be_empty
    end

    it "should not allow a user to be created without a unique email" do
      user1 = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      expect { user1.save! }.to_not raise_error
      user2 = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should not allow a user to be created without a first name" do
      user = User.new(first_name: nil, last_name: "Paws", email: "vp@example.com", password: "test123", password_confirmation: "test123")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should not allow a user to be created without a last name" do
      user = User.new(first_name: "Vinny", last_name: nil, email: "vp@example.com", password: "test123", password_confirmation: "test123")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should not allow a user to be created without a password" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "vp@example.com", password: nil, password_confirmation: "test123")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not allow a user to be created without a password confirmation" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "vp@example.com", password: "test123", password_confirmation: nil)
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should not allow a user to be created without matching password and password confirmations" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "vp@example.com", password: "test123", password_confirmation: "test234")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not allow a user to be created with a password less than 6 characters" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "vp@example.com", password: "test1", password_confirmation: "test1")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe "authenticate_with_credentials" do
    it "returns the user when authenticated with correct credentials" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      user.save
      authenticated_user = User.authenticate_with_credentials('test@example.com', "test123")
      expect(authenticated_user).to eq(user)
    end

    it "returns nil when email does nto exist" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      user.save
      authenticated_user = User.authenticate_with_credentials('fake', "test123")
      expect(authenticated_user).to be_nil
    end

    it "returns nil when password is incorrect" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      user.save
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'test234')
      expect(authenticated_user).to be_nil
    end

    it "ignores whitespace" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      user.save
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', "test123")
      expect(authenticated_user).to eq(user)
    end

    it "is is not case sensative for email" do
      user = User.new(first_name: "Vinny", last_name: "Paws", email: "test@example.com", password: "test123", password_confirmation: "test123")
      user.save
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', "test123")
      expect(authenticated_user).to eq(user)
    end
  end
end
