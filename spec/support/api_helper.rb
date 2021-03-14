# frozen_string_literal: true

module ApiHelper
  def json_response
    # punting on memoizing for now. we can find a solution later that memoizes
    # per request_id or something similar
    JSON.parse(@response.body)
  end
end
