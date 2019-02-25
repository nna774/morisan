require 'json'
require 'net/https'

WH_URI = ENV['WH_URI']
DEFAULT_EMOJI = ENV['DEFAULT_EMOJI']
DEFAULT_USERNAME = ENV['DEFAULT_USERNAME']

def handler(event:, context:)
  body = {}
  body[:channel] = event['channel'] if event['channel']
  if event['icon_url']
    body[:icon_url] = event['icon_url']
  else
    body[:icon_emoji] = event['icon_emoji'] || DEFAULT_EMOJI
  end
  body[:username] = event['username'] || DEFAULT_USERNAME
  body[:text] = event['text']

  pl = 'payload=' + body.to_json

  uri = URI.parse(WH_URI)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  req = Net::HTTP::Post.new(uri.request_uri)
  req.body = pl
  res = https.request(req)
  { status: :ok }
end
