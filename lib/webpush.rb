module Webpush
  require 'net/http'
  require 'uri'
  require 'json'

  def send_web(id, title, body)
    conn = Faraday.new(:url => 'http://95.156.255.35:8100')
    conn.post do |req|
      req.url '/send'
      req.headers['Content-Type'] = 'application/json'
      req.body = {id: id, title: title, body: body}.to_json
    end
  end
end
