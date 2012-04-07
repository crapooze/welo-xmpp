
$LOAD_PATH.unshift './lib'
require './samples/user'
require 'blather/client'

when_ready do
  puts "ready to receive"
end

message do |m|
  puts "normal message received"
  p m
end

user_received do |m|
  puts "message with user"
  p m
end

user_full_received do |m|
  puts "message with user in perspective 'full' received"
  p m
end
