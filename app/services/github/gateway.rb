require 'httparty'

module Github
  class Gateway
    include HTTParty
    format :json

    base_uri 'https://api.github.com'

    def self.get_private_gists(user)
      response = get("/gists?access_token=#{user.oauth_token}")
      self.process(response)
    end

    private

    def self.process(response)
      response = response.parsed_response
      gists = []
      response.each do |gist|
        gists << gist['description'] unless gist['public']
      end
      gists
    end

  end
end
