class VotesController < ApplicationController
	before_action :authenticate_user!
	
	# Create new votes for poll options
	def create
    	if params[:options].class == String
    		@new_vote = Vote.new(:user => current_user, :option_vote => 1, :option_id => params[:options].to_i)
		    @new_vote.save!
		else    
    	params[:options].each do |key, value|
      	   	if value != "" && value != "0"
		      	@new_vote = Vote.new(:user => current_user, :option_vote => 1, :option_id => key.to_i)
		      	@new_vote.save!
		    end
	  	end
	  	end
		respond_to do |format|
	    	option = Option.where(:id => @new_vote.option_id).first
	    	poll = Poll.where(:id => option.poll_id).first
	      	format.html { redirect_to poll_path(poll.id), notice: 'Thanks for your voice!' }
	  	end
	end
	
	private

	def vote_params
	  params.require(:vote).permit(:option_vote, :user_id, :option_id, :poll_option, {:options => []})
	end

end
