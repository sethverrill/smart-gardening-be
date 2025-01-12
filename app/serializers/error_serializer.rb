class ErrorSerializer
    def self.format_error(error_message)
      {
        message: error_message.message,
        status: error_message.status_code
      }
    end
  
    def self.format_errors(messages)
      {
        message: 'Your query could not be completed',
        errors: messages
      }
    end
  end