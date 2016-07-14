class Poll < ActiveRecord::Base
	belongs_to :user
	has_many :options, -> { includes :votes }, dependent: :destroy
	accepts_nested_attributes_for :options
	validates_presence_of :title, :body, :user_id
end
