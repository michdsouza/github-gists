describe Github::Gateway do
  let(:user) { FactoryBot.create(:user, oauth_token: 'my-access-token') }

  describe '.get_gists' do
    context 'response successful' do
      it 'gets private gists for a user' do
        VCR.use_cassette('github/gists') do
          gists = Github::Gateway.get_gists(user)
          expect(gists).to be_a Array
          expect(gists.size).to eq 8
        end
      end
    end

    context 'response unsuccessful' do
      it 'raises an error' do
        VCR.use_cassette('github/gists_error') do
          expect { Github::Gateway.get_gists(user) }.to raise_error(Github::ApiError)
        end
      end
    end
  end

  describe '.create' do
    let(:new_gist) { '{"description":"Test gist 22121","filename":"","content":"fafdsdfdsfsf"}' }

    context 'response successful' do
      it 'creates a private gist' do
        VCR.use_cassette('github/create') do
          response = Github::Gateway.create(new_gist, user)
          expect(response.created?).to be_truthy
        end
      end
    end

    context 'response unsuccessful' do
      it 'raises an error' do
        VCR.use_cassette('github/create_error') do
          expect { Github::Gateway.create(new_gist, user) }.to raise_error(Github::ApiError)
        end
      end
    end
  end

  describe '.get_gist' do
    let(:gist_id) { 'b9287745812127f5929c21bc781d77ed' }

    context 'response successful' do
      it 'gets a gist by id' do
        VCR.use_cassette('github/get_gist') do
          gist = Github::Gateway.get_gist(gist_id, user)
          expect(gist.id).to eq gist_id
          expect(gist.description).to eq 'Test description 123'
        end
      end
    end

    context 'response unsuccessful' do
      it 'raises an error' do
        VCR.use_cassette('github/get_gist_error') do
          expect { Github::Gateway.get_gist(gist_id, user) }.to raise_error(Github::ApiError)
        end
      end
    end
  end

  describe '.update_gist' do
    let(:gist_id) { '7eec1175afef86ca8010c91d1d013ed7' }

    let(:edited_gist) do
      {
        description: 'Updated private gist',
        filename: 'gistfile500.txt',
        content: 'updated content'
      }.to_json
    end

    context 'response successful' do
      it 'updates a gist' do
        VCR.use_cassette('github/update_gist') do
          response = Github::Gateway.update_gist(gist_id, edited_gist, user)
          expect(response.ok?).to be_truthy
        end
      end
    end

    context 'response unsuccessful' do
      it 'raises an error' do
        VCR.use_cassette('github/update_gist_error') do
          expect { Github::Gateway.update_gist(gist_id, edited_gist, user) }.to raise_error(Github::ApiError)
        end
      end
    end
  end

  describe '.delete_gist' do
    let(:gist_id) { 'ba851ffc2bfe4ad9e870cad23559ea3b' }

    context 'response successful' do
      it 'deletes a gist' do
        VCR.use_cassette('github/delete_gist') do
          response = Github::Gateway.delete_gist(gist_id, user)
          expect(response.success?).to be_truthy
        end
      end
    end

    context 'response unsuccessful' do
      it 'raises an error' do
        VCR.use_cassette('github/delete_gist_error') do
          expect { Github::Gateway.delete_gist(gist_id, user) }.to raise_error(Github::ApiError)
        end
      end
    end
  end
end
