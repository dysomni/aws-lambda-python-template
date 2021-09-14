require 'json'
require 'active_support/security_utils'
require 'aws-sdk'

class App
  class AuthError < StandardError; end

  def self.process(*args)
    App.log('starting new request')
    new(*args).run
  end

  def self.log(message)
    puts "#{Time.now} :: #{message}"
  end

  attr_accessor :event, :context

  def initialize(event, context)
    @event = event
    @context = context
  end

  def run
    authorize if ENV['AUTH']

    # your code here! then return a response
    response(message: 'ran successfully!', data: { put: 'your', extra: 'data', here: [1,2,3] })
  rescue AuthError => e
    App.log('authorization failed')
    response(code: 406, message: 'you are not authorized')
  rescue => e
    App.log("#{e.class}: #{e.message}")
    response(code: 500, message: e.message || 'there was an error')
  end

  private

  def authorize
    auth = event.[]('headers')&.[]('authorization')
    raise AuthError unless ActiveSupport::SecurityUtils.secure_compare(ENV['AUTH'], auth)
    App.log('authorization successful')
  end

  def response(**options)
    options[:data] ||= {}
    options[:code] ||= 200
    success = options[:code] == 200

    {
      statusCode: options[:code],
      body: JSON.generate({ success: success, message: options[:message], data: options[:data] }),
      headers: { 'content-type' => 'application/json' }
    }
  end
end