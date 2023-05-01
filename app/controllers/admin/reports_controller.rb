module Admin
  class ReportsController < ApplicationController

    before_action :ensure_admin , only: [ :index ]

    def index
      @orders = Order.where(created_at: DateTime.current.beginning_of_day-5.day..DateTime.current.midnight)
      unless report_params[:from_date].blank? && report_params[:to_date].blank?
        @from = report_params[:from_date]
        @to = report_params[:to_date]
        @selected_date_orders = Order.where(created_at: DateTime.parse(@from)..DateTime.parse(@to))
      end
    end

    private
    def report_params
      params.permit(:from_date, :to_date)
    end

    def ensure_admin
      if User.find_by(id: session[:user_id]).role != 'admin'
        flash[:notice] = "You don't have privilege to access this section"
        redirect_to '/'
      end
    end
  end
end
