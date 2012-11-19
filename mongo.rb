require 'em-websocket'
require 'em-websocket-client'
require 'mongo'
require 'term/ansicolor'
require 'pry'
require 'json'


class String; include Term::ANSIColor; end

EventMachine.run {

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    
    ws.onopen { puts "\nWebSocket connection open".yellow }

    ws.onclose { puts "WebSocket Connection closed".red }

    ws.onmessage do |msg|
      puts "\nReceived message: #{msg.cyan}"
      @client = Mongo::Connection.new('localhost', 27017, :safe => true)
			@db = @client['fetcher']
			@coll = @db['test']
      final = JSON.parse msg
      id = final["properties"]["Item#id"].join
      begin
        @coll.insert(id => final)
        puts "\nThe Tweet with id : #{id.to_s} has been inserted in mongo Database\n".green
      rescue Exception => e 
			  binding.pry    	
        puts "Got a problem : #{e.message}".red
      end
    end

  end
}