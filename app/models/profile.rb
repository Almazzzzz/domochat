class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  def full_name
    [self.first_name, self.middle_name, self.last_name].join(" ")
  end

end
