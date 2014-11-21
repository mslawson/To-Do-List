require 'spec_helper'

describe "Viewing todo items" do 
	let(:user) { todo_list.user }
	let!(:todo_list) {create(:todo_list)}

	before do
		sign_in user, password: "treehouse1"
	end  

	it "displays the title of the todo list" do
		visit_todo_list(todo_list)
		within(".list-title h1") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")
		todo_list.todo_items.create(content: "Bread")
		visit_todo_list(todo_list)
		expect(page.all("table.todo_items tr").size).to eq(4)
		within "tr#todo_item_1" do
			expect(page).to have_content("Milk")
		end
		

	end

end