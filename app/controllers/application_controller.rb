class ApplicationController < ActionController::Base
  def render_status(status)
    render file: "#{Rails.root}/public/#{status}.html", status: status
  end

  def parse_date
    @date = params[:date]&.to_date || Date.today
  rescue ArgumentError
    @date = Date.today
  end
end
