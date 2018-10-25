require 'httparty'

module Github
  class Gateway
    include HTTParty
    format :json

    base_uri 'https://api.github.com'

    # API: Index
    def self.get_gists(user)
      response = get("/gists?access_token=#{user.oauth_token}")
      response.ok? ? self.translate(response) : raise(ApiError)
    end

    # API: Create
    def self.create(gist, user)
      gist = JSON.parse(gist)
      body = { description: gist['description'], files: { "#{gist['filename']}": {content: gist['content']} } }.to_json
      headers = { "Authorization": "token #{user.oauth_token}", "User-Agent": "github-gists"}
      response = post("/gists", body: body, headers: headers)
      response.created? ? response : raise(ApiError)
    end

    # API: Read
    def self.get_gist(gist_id, user)
      response = get("/gists/#{gist_id}?access_token=#{user.oauth_token}")
      response.ok? ? self.make_gist(response) : raise(ApiError)
    end

    # API: Update
    def self.update_gist(gist_id, gist, user)
      gist = JSON.parse(gist)
      body = { description: gist['description'], files: { "#{gist['filename']}": {content: gist['content']} } }.to_json
      headers = { "Authorization": "token #{user.oauth_token}", "User-Agent": "github-gists"}
      response = patch("/gists/#{gist_id}", body: body, headers: headers)
      response.ok? ? response : raise(ApiError)
    end

    # API: Delete
    def self.delete_gist(gist_id, user)
      response = delete("/gists/#{gist_id}?access_token=#{user.oauth_token}")
      response.success? ? response : raise(ApiError)
    end

    private

    def self.translate(response)
      response = response.parsed_response
      response.select { |gist| !gist['public'] }
              .map { |gist| Gist.new(gist['id'], gist['description'], gist['filename']) }
    end

    def self.make_gist(response)
      gist = Gist.new(response['id'], response['description'], response['files'].first[0], response['files'].first[1]['content'])
    end

  end
end
