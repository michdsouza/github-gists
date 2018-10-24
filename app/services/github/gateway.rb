require 'httparty'

module Github
  class Gateway
    include HTTParty
    format :json

    base_uri 'https://api.github.com'

    def self.get_private_gists(user)
      response = get("/gists?access_token=#{user.oauth_token}")
      self.process_gists(response)
    end

    def self.save(gist, user)
      gist = JSON.parse(gist)
      body = { description: gist['description'], files: { "#{gist['filename']}": {content: gist['content']} } }.to_json
      headers = { "Authorization": "token #{user.oauth_token}", "User-Agent": "github-gists"}
      response = post("/gists", body: body, headers: headers)
      # TODO error handling
    end

    def self.get_gist(gist_id, user)
      response = get("/gists/#{gist_id}?access_token=#{user.oauth_token}")
      self.process_gist(response)
      # TODO error handling
    end

    def self.update_gist(gist_id, gist, user)
      gist = JSON.parse(gist)
      body = { description: gist['description'], files: { "#{gist['filename']}": {content: gist['content']} } }.to_json
      headers = { "Authorization": "token #{user.oauth_token}", "User-Agent": "github-gists"}
      response = patch("/gists/#{gist_id}", body: body, headers: headers)
      # TODO error handling
    end

    private

    def self.process_gists(response)
      response = response.parsed_response
      gists = []
      response.each do |gist|
        unless gist['public']
          gists << {id: gist['id'], description: gist['description']}
        end
      end
      gists
    end

    def self.process_gist(response)
      gist = Gist.new(response['id'],
                      response['description'],
                      response["files"].first[0],
                      response["files"].first[1]['content'])
    end

  end
end
