class PollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all.order("status ASC")
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @options = Option.where(:poll_id => @poll.id) 
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    #@poll.options.build
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    @poll.status = 2
    @poll.user = @user

    respond_to do |format|
      if @poll.save && check_poll_datetime
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

  private
    def check_poll_datetime
      if @poll.finish > @poll.start && @poll.start > Time.now && @poll.finish > Time.now 
        return true 
      else
        flash[:alert] = "You set the wrong start or finish time."
        return false
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title, :body, :start, :finish, :status, :poll_type, :user_id, options_attributes: [:poll_option])
    end

end
