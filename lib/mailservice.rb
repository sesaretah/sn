module Mailservice
  require 'net/http'
  require 'uri'
  require 'json'
  require 'openssl'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def send_mail(to, subject , text, url)
    conn = Faraday.new(:url => 'https://sn.ut.ac.ir:4200')
    conn.post do |req|
      req.url '/mail'
      req.headers['Content-Type'] = 'application/json'
      req.body = {to: to, subject: subject, text: text, url: url}.to_json
    end
  end
end
