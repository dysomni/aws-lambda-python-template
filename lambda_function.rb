require_relative './lib/app'

def lambda_handler(event:, context:)
  App.process(event, context)
end
