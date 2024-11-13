class ErrorSerializer
  def self.format_error(exception, status)
    {
      message: 'Subscription not found',
      errors: [exception.message]
    }
  end
end