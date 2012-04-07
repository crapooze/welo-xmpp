$LOAD_PATH.unshift './lib'
require './samples/user'
require 'blather/client'

RECEIVER = receiver_jid

when_ready do 
  p :ready
  jon = User.new('jon')
  msg = jon.as_xmpp_message RECEIVER
  p msg
  write_to_stream msg

  msg2 = jon.as_xmpp_message RECEIVER, :full
  p msg2
  write_to_stream msg2
end


