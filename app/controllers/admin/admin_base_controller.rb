class Admin::AdminBaseController < ApplicationController

  before_action :ensure_admin, only: [:index]

  private
  def ensure_admin
    if User.find_by(id: session[:user_id]).role != 'admin'
      flash[:notice] = "You don't have privilege to access this section"
      redirect_to '/'
    end
  end
end
