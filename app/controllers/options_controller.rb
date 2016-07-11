class OptionsController < ApplicationController

    def option_params
      params.require(:option).permit(:poll_option, :poll_id)
    end 
end
