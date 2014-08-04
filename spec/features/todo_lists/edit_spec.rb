require 'spec_helper'

describe "editing to do lists" do 
	let!(:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List.")}

	def update_to_do_list(options={})
		options[:title] ||= "My to-do list"
		options[:description] ||= "This is what I do.  All day, every day."
		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
				click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end

	it "updates a to-do list successfully with correct information" do
			
			update_to_do_list todo_list: todo_list, 
												title: "New Title", 
												description: "New Description"

			todo_list.reload

			expect(page).to have_content("Todo list was successfully updated.")
			expect(todo_list.title).to eq("New Title")
			expect(todo_list.description).to eq("New Description")
	end 

	it "displays an error with no title" do
		update_to_do_list todo_list: todo_list,
											title: ""
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content("error")
	end

	it "displays an error with a short title" do 
		update_to_do_list todo_list: todo_list,
											title: "1234"
		expect(page).to have_content("error")
	end

	it "displays an error with no description" do 
		update_to_do_list todo_list: todo_list,
											description: ""
		expect(page).to have_content("error")
	end

	it "displays an error with a short description" do
		update_to_do_list todo_list: todo_list,
											description: "123456"
		expect(page).to have_content("error")
	end


end
