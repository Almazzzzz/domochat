class ChatMessage < ActiveRecord::Base
  belongs_to :user
  sync :all
end
