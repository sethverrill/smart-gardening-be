class ErrorSerializer
  
    def self.format_errors(messages)
      {
        message: 'Your query could not be completed',
        errors: messages
      }
    end
end