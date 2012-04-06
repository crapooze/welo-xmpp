require 'blather'
require 'welo-xmpp/stanza'

module Welo::Xmpp
  class Message < Blather::Stanza::Message
    include Stanza
    # creates a new message with a welo_node inside to hold a resource
    def self.new(to, body=nil, type=:chat)
      node = super
      node.welo_node
      node
    end

    # imports a Welo::XMPP message from a mere XML node
    def self.import(node)
      new(node.element_name).inherit(node)
    end

    # removes the welo_node created by the call to new before inheriting the
    # children
    def inherit(node)
      welo_node.remove
      super
    end

  end
end

