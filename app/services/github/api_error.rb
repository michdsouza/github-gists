module Github
  class ApiError < StandardError
    def message
      'An error occurred connecting to Github. Please check your network connection and try again.'
    end
  end
end
