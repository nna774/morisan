require 'json'
require 'aws-sdk-sqs'

QUEUE_URL = ENV['QUEUE_URL']
REGION = ENV['REGION']

def handler(event:, context:)
  body = {}
	body[:type] = 'slack'
  body[:text] = event['text']
  body[:channel] = event['channel'] if event['channel']
  body[:icon_url] = event['icon_url'] if event['icon_url']
  body[:icon_emoji] = event['icon_emoji'] if event['icon_emoji']
 	body[:username] = event['username'] if event['username'] 
  sqs = Aws::SQS::Client.new(region: REGION)
  res = sqs.send_message({
    queue_url: QUEUE_URL,
    message_body: body.to_json,
  })
  { code: 201, status: :ok }
end
