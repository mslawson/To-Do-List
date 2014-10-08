require "spec_helper"

describe "Signing up" do 
	it "allows a user to sign up for the site and creates an object in the database" do 
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up") 
		click_link "Sign Up"

		fill_in	"First Name", with: "Matt"
		fill_in "Last Name", with: "Slawson"
		fill_in "Email", with: "matt@slawson.com"
		fill_in "Password", with: "treehouse123"
		fill_in "Password (again)", with: "treehouse123"
		click_button "Sign Up"

		expect(User.count).to eq(1)


	end
end