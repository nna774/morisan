require 'aws-sdk-lambda'
require 'json'

def handler(event:, context:)
  client = Aws::Lambda::Client.new
  client.invoke({
    function_name: ENV['function_name'],
    invocation_type: 'Event',
    client_context: 'say-hello-megumi',
    payload: {
      text: 'hello',
      }.to_json,
  })
  { status: :ok }
end
