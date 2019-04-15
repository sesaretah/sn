module Webpush
  require 'net/http'
  require 'uri'
  require 'json'
  require 'openssl'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def send_web(id, title, body)
    conn = Faraday.new(:url => 'https://sn.ut.ac.ir:4200')
    conn.post do |req|
      req.url '/send'
      req.headers['Content-Type'] = 'application/json'
      req.body = {id: id, title: title, body: body}.to_json
    end
  end
end
