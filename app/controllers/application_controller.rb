class ApplicationController < ActionController::Base
  def render_status(status)
    render file: "#{Rails.root}/public/#{status}.html", status: status
  end
end
