class Option < ActiveRecord::Base
  belongs_to :poll
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :votes
  validates_presence_of :poll_option, :pol_id
end
