class VotesController < ApplicationController
	before_action :authenticate_user!
	
	def create
    	params[:options].each do |option|
      	   	if option[1] != "" && option[1] != "0"
		      	@vote = Vote.new
		      	@vote.user = current_user
		      	@vote.option_vote = 1
		      	@vote.option_id = option[0].to_i
		      	@vote.save!
		    end
	  	end
		respond_to do |format|
	    		option = Option.where(:id => @vote.option_id).first
	    		poll = Poll.where(:id => option.poll_id).first
	      		format.html { redirect_to poll_path(poll.id), notice: 'Thanks for your voice!' }
	  	end
	end
	
	def show
	end	

	private

	def vote_params
	  params.require(:vote).permit(:option_vote, :user_id, :option_id, :poll_option)
	end
end
