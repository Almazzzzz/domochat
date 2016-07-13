class PollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_poll, only: [:voting, :show, :edit, :update, :destroy]
  before_action :set_editing_time, only: [:edit, :show, :index, :my_index]
  
  # Set editing poll time limit
  def set_editing_time
  	@editing_time = 10.hour
  end

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all.order("status ASC")
  end
  
  def my_index
    @polls = current_user.polls.order("status ASC")
  end


  # GET /polls/1
  # GET /polls/1.json
  def show
    # Вынести определение @options или @poll.options (везде по-разному) в отдельный метод
    #@options = Option.where(:poll_id => @poll.id)
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    @option = Option.new
  end

  # GET /polls/1/edit
  def edit
  	# Если успею, то вынести в отдельные методы
  	alert_string = ''
  	if @poll.user != current_user || (DateTime.now.to_i - @poll.created_at.to_i) > @editing_time
  		if @poll.user != current_user
  			alert_string = "Sorry! You can edit only your own polls. "
  			path = my_polls_path
  		end
  		if (DateTime.now.to_i - @poll.created_at.to_i) > @editing_time
  			alert_string = alert_string + "Sorry! You can't edit this poll, 'cause editing time limit is over."
  			path = @poll
  		end			
			respond_to do |format|
  			format.html { redirect_to path, alert: alert_string }
  		end
  	end
  end

  # GET /polls/1/voting
  def voting
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.status = 1
    @poll.user = current_user

    respond_to do |format|
      if check_poll_datetime && @poll.save
        save_poll_options
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)# && check_poll_datetime
        save_poll_options
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def save_poll_options
    if @poll.options.empty?
      params[:options].each do |option|
        if option[:poll_option] != ""
          new_option = Option.new
          new_option.poll_option = option[:poll_option]
          new_option.poll_id = @poll.id
          new_option.save!
        end
      end
    else
      params[:options].each do |option|
        if option[1] != ""
          update_option = Option.where(:id => option[0].to_i).first
          update_option.poll_option = option[1]
          update_option.save!
        end
      end
    end
  end

  def results
    @options = @poll.options
  end

  private

    def check_poll_datetime
      if @poll.finish > @poll.start && @poll.start > DateTime.now && @poll.finish > DateTime.now 
        return true 
      else
        flash[:alert] = "You set the wrong start or finish time."
        return false
      end
    end
    
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:title, :body, :start, :finish, :status, :poll_type, :user_id, options_attributes: [:poll_option])
    end

end
