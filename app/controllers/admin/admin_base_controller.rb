class Admin::AdminBaseController < ApplicationController

  before_action :ensure_user_is_admin, only: [:index]

  private

  def ensure_user_is_admin
    unless current_user.admin?
      flash[:notice] = "You don't have privilege to access this section"
      redirect_to '/'
    end
  end
end
