class Poll < ActiveRecord::Base
	belongs_to :user
	has_many 						:options, -> { includes :votes }, dependent: :destroy
	accepts_nested_attributes_for 	:options
	validates_presence_of 			:title, :body, :user_id
	scope 							:opened, -> { where(status: 1) }
	scope 							:before, -> { where(status: 2) }
	scope 							:closed, -> { where(status: 3) }
end
