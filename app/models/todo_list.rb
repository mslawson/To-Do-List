class TodoList < ActiveRecord::Base
	has_many :todo_items

	validates :title, :description, presence: true
	validates :title, length: {minimum: 5}
	validates :description, length: {minimum: 7}

	def has_completed_items?  
		todo_items.complete.size > 0 
	end

	def has_incompleted_items?
		todo_items.incomplete.size > 0
	end
end