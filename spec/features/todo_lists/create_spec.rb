require 'spec_helper'

describe "creating to do lists" do 
	def create_to_do_list(options={})
		options[:title] ||= "My to-do list"
		options[:description] ||= "This is what I do.  All day, every day."
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo lists index page on success" do
		create_to_do_list
		expect(page).to have_content("My to-do list")
	end


	it "displays an error when the todo list doesn't have a title" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title:""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I do.")
	end

	it "displays an error when the todo list has a title less than 5 characters" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title:"okay"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I do.")
	end

	it "displays an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title: "Grocery List", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end

	it "displays an error when the todo list has a description less than 7 characters" do
		expect(TodoList.count).to eq(0)

		create_to_do_list title:"Grocery List", description:"123456"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end
end