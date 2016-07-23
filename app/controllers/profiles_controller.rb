class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    @user = current_user
    @user.profile.update(permit_profile)
    redirect_to profile_path
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def permit_profile
    params.require(:profile).permit(:first_name, :last_name, :middle_name, :phone, :avatar)
  end

end
