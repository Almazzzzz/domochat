class Vote < ActiveRecord::Base
  belongs_to :option
  belongs_to :user
  validates_presence_of :option_vote, :option_id, :user_id
end
