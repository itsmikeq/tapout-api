# frozen_string_literal: true

require 'sinatra/base'

class TestWebServer < Sinatra::Base
  get '/api/v1/campaigns' do
    json_response 200
  end

  get '/api/v1/campaigns/:id' do
    json_response 200, params['id']
  end

  private

  def json_response(response_code, id = nil)
    content_type :json
    status response_code
    if id
      JSON.parse(File.open(File.dirname(__FILE__) + '/../fixtures/campaign_data.json', 'rb').read).detect do |e|
        Integer(e['id']) == Integer(id)
      end
    else
      JSON.parse(File.open(File.dirname(__FILE__) + '/../fixtures/campaign_data.json', 'rb').read)
    end.to_json
  end
end
