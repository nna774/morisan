require 'aws-sdk-lambda'
require 'json'

def handler(event:, context:)
  client = Aws::Lambda::Client.new
  event['Records'].each do |record|
    body = JSON.parse(record['body'])
    case body['type']
    when 'slack'
      res = client.invoke({
        function_name: ENV['function_name'],
        invocation_type: 'Event',
        client_context: 'mother-mori',
        payload: body.to_json
      })
    else
      throw "unknown type: #{body['type']}"
    end
  end
  { status: :ok }
end
