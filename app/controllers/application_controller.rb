class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  # catch exceptions which are not caught below
  rescue_from Exception, with: :handle_500 unless Rails.env.development?

  # 404 Not Found
  rescue_from ActionController::RoutingError, with: :handle_404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :handle_404 unless Rails.env.development?

  # Error handling
  def handle_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render json: {error: '500 error' }, status: 500
  end

  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render json: {error: '404 error'}, status: 404
  end

end
