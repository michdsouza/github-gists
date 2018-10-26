require 'httparty'

module Github
  class Gateway
    include HTTParty
    format :json

    base_uri 'https://api.github.com'

    # API: Index
    def self.get_gists(user)
      response = get('/gists', headers: auth_headers(user))
      response.ok? ? translate(response) : raise(ApiError)
    end

    # API: Create
    def self.create(gist, user)
      gist = JSON.parse(gist)
      body = {
        description: gist['description'],
        files: {
          (gist['filename']).to_s => {
            content: gist['content']
          }
        }
      }.to_json

      response = post('/gists', body: body, headers: auth_headers(user))
      response.created? ? response : raise(ApiError)
    end

    # API: Read
    def self.get_gist(gist_id, user)
      response = get("/gists/#{gist_id}", headers: auth_headers(user))
      response.ok? ? make_gist(response) : raise(ApiError)
    end

    # API: Update
    def self.update_gist(gist_id, gist, user)
      gist = JSON.parse(gist)
      body = {
        description: gist['description'],
        files: {
          (gist['filename']).to_s => { content: gist['content'] }
        }
      }.to_json

      response = patch("/gists/#{gist_id}", body: body, headers: auth_headers(user))
      response.ok? ? response : raise(ApiError)
    end

    # API: Delete
    def self.delete_gist(gist_id, user)
      response = delete("/gists/#{gist_id}", headers: auth_headers(user))
      response.success? ? response : raise(ApiError)
    end

    def self.auth_headers(user)
      {
        'Authorization' => "token #{user.oauth_token}",
        'User-Agent'    => 'github-gists'
      }
    end

    def self.translate(response)
      response = response.parsed_response
      response.reject { |gist| gist['public'] }
              .map { |gist| Gist.new(gist['id'], gist['description'], gist['filename']) }
    end

    def self.make_gist(response)
      Gist.new(
        response['id'],
        response['description'],
        response['files'].first[0],
        response['files'].first[1]['content']
      )
    end
  end
end
