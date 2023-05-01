class Admin::ReportsController < Admin::AdminBaseController

  def index
    from = params[:from_date].presence || DateTime.current.end_of_day - 5.day
    to = params[:to_date].presence || DateTime.current.midnight
    @orders = Order.by_date(from: from.to_time, to: to.to_time)
  end
end
