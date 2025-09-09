require 'spec_helper'

describe 'Temp Header plugin' do
  describe 'GET /plugins/temp_headers' do
    it 'gets the temp header record an error' do
      get '/plugins/temp_headers', params = { }

      expect(last_response).to be_ok
      expect(last_response.body).not_to include('error')
      expect(last_response.body).not_to be_empty
    end
  end

  describe 'POST /plugins/temp_headers' do
    let(:existing) { JSONModel(:temp_header).all.first }
    let(:header_update) do
      existing['maintenance_message'] = 'A message.'
      existing.to_json
    end

    context 'when a user with administer system permissions' do
      it 'updates the header' do
        post '/plugins/temp_headers', header_update
        puts last_response.body

        expect(last_response).to be_ok
        expect(last_response.body).not_to include('error')
        expect(last_response.body).to include('Updated')
      end
    end

    context 'when a user without administer system permissions' do
      before do
        make_test_user('archivist')
      end

      it 'denies access' do
        as_test_user('archivist') do
          post '/plugins/temp_headers', header_update
        end

        expect(last_response).not_to be_ok
        expect(last_response.body).to include('error')
        expect(last_response.body).to match(/Access denied/)
      end
    end
  end
end
