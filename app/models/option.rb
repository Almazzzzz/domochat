class Option < ActiveRecord::Base
  belongs_to :poll
  has_one :vote, dependent: :destroy
end
