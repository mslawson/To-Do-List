require 'spec_helper'

describe User do
	let(:valid_attributes) {
	{
		first_name:"John",
		last_name:"Doe",
		email: "jdoe@gmail.com"
	}
}
	context "validations" do 
		let(:user) { User.new(valid_attributes)}

		before do
			User.create(valid_attributes)
		end

		it "requires an email" do
			expect(user).to validate_presence_of(:email)
		end

		it "requires a unique email" do 
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires a unique email case insensitive" do
			user.email = "JASON@TEAMTREEHOUSE.COM"
			expect(user).to validate_uniqueness_of(:email)
		end

	end

	describe "#downcase_email" do
		it "makes the email attribute lowercase" do
			user = User.new(valid_attributes.merge(email: "JASON@TEAMTREEHOUSE.COM"))
			user.downcase_email
			expect(user.email).to eq("jason@teamtreehouse.com") 
		end

		it "downcase an email before saving" do
			user = User.new(valid_attributes)
			user.email = "MIKE@TEAMTREEHOUSE.com"
			expect(user.save).to be_true
			expect(user.email).to eq("mike@teamtreehouse.com") 
		end

	end

end
