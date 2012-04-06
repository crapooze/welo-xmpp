require 'blather/client/dsl/pubsub'

module Welo::Xmpp
  class PubSub < Blather::DSL::PubSub
    def publish(node, payload, persp=nil, host=nil)
      case payload
      when Welo::Resource
        stanza = Blather::Stanza::PubSub::Publish.new(send_to(host), node, :set)
        stanza.payload = payload.as_welo_node(persp)
        request(stanza) { |n| yield n if block_given? }
      else
        super(node, payload, host)
      end
    end
  end
end

