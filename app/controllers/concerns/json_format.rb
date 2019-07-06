module JsonFormat
  extend ActiveSupport::Concern

  def json_format(status, message, data)
    render json: {
      status: status,
      message: message,
      data: data
    }
  end
end
