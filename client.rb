require 'em-websocket'
require 'em-websocket-client'
require 'em-websocket-request'
require 'pry'	

EM.run do

  conn = EventMachine::WebSocketClient.connect("ws://localhost:8080/")


  @tweet = {"type"=>["http://schema.org/Article/Small"],
 "properties"=>
  {"additionalType"=>["http://getfetcher.net/Item"],
   "Item#id"=>[172070369035956220],
   "articleBody"=>
    ["The \"http://\" at the beginning of URLs is a command to the browser. It stands for \"head to this place:\" followed by two laser-gun noises."],
   "author"=>
    [{"type"=>["http://schema.org/Person/User"],
      "properties"=>
       {"additionalType"=>["http://getfetcher.net/Item"],
        "Item#id"=>[63846421],
        "name"=>["Brian Sutorius"],
        "User#dateRegistered"=>[1249685355],
        "description"=>
         ["Every day I wake up and put on my gym shorts one leg at a time."],
        "url"=>["https://twitter.com/bsuto"]}}],
   "Item#viewer"=>
    [{"type"=>["http://schema.org/Person/User"],
      "properties"=>
       {"additionalType"=>["http://getfetcher.net/Item"],
        "Item#id"=>[173389269],
        "name"=>["Xavier Via"],
        "User#dateRegistered"=>[1280656367],
        "description"=>
         ["Web Developer specialized in Ruby.\r\n\r\nComputer Science enthusiast."],
        "url"=>["https://twitter.com/xaviervia"]}}],
   "dateCreated"=>[1329859747],
   "provider"=>["twitter", "web"],
   "url"=>["https://twitter.com/bsuto/status/172070369035956224"]}}



  conn.callback do
    #conn.send_msg 'yepla'
    conn.send_msg @tweet
  	#binding.pry
  end





  conn.errback do |e|
    puts "Got error: #{e}"
  end

  conn.stream do |msg|
    puts "<#{msg}>"
    if msg == "done"
      conn.close_connection
    end
  end

  conn.disconnect do
    puts "gone"
    EM::stop_event_loop
  end

end