class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  enable_sync

  def index
    @chat_messages = ChatMessage.all.order("created_at ASC")
    respond_to do |format|
      format.html
      format.json { render json: @chat_messages }
    end
  end

  def create
    @chat_message = current_user.chat_messages.build(chat_message_params)
    respond_to do |format|
      if @chat_message.save
        sync_new @chat_message
      else
        format.json { render json: @chat_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message)
  end

end
