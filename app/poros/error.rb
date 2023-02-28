class Error
  attr_reader :messages, :status

  def initialize(error)
    @messages = convert_messages(error)
    @status = find_status[error.class].to_s
  end

  def convert_messages(error)
    if error.instance_of?(ActiveModel::Errors)
      error.full_messages
    else
      [error.message]
    end
  end

  def find_status
    {
      ActiveRecord::RecordNotFound => 404,
      ActiveModel::Errors => 422,
      ActiveRecord::StatementInvalid => 404
    }
  end
end
