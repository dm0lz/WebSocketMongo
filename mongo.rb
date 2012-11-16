require 'em-websocket'
require 'em-websocket-client'
require 'mongo'
require 'term/ansicolor'
require 'pry'

class String; include Term::ANSIColor ; end

EventMachine.run {

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    
    ws.onopen { puts "WebSocket connection open".blue }

    ws.onclose { puts "Connection closed" }

    ws.onmessage do |msg|
      puts "Received message: #{msg.red}"
      @client = Mongo::Connection.new('localhost', 27017, :safe => true)
			@db = @client['fetcher']
			@coll = @db['test']

			binding.pry    	
    end

  end
}