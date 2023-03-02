class ErrorSerializer
  def self.serialize(error)
    {
      "message": 'There was an error processing your request',
      "errors": error.messages,
      "status": error.status
    }
  end
end
