require 'blather'
require 'welo-xmpp/stanza'

module Welo::Xmpp
  class WeloNode < Blather::XMPPNode
    include Stanza
  end
end

