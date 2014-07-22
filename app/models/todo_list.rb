class TodoList < ActiveRecord::Base
	validates :title, :description, presence: true
	validates :title, length: {minimum: 5}
	validates :description, length: {minimum: 7}
end
