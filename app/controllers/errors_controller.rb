class ErrorsController

  def self.bad_request
    format_error(404, "Bad Request")
  end

  private

  def self.format_error(code, message)
    {
      error: {
        code: code,
        message: message
      }
    }
  end
end