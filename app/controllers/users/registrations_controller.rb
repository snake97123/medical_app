class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :destroy

  def check_guest
    if resources.email == 'guest@example.com'
      redirect_to root_path
    end
  end
end
