require 'welo-xmpp'

class User
  include Welo::Xmpp::Resource
  attr_accessor :name, :id
  perspective :default, [:name]
  perspective :full, [:name, :id]
  def initialize(name)
    @name = name
    @id   = rand 10000
  end
end


User.to_xmpp_node(:default) #generates user_received's method
User.to_xmpp_node(:full)    #generates user_full_received's method

