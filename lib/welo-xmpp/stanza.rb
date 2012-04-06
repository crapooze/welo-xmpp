
module Welo::Xmpp
  module Stanza
    def self.included(mod)
      mod.extend ClassMethods
    end

    module ClassMethods
      attr_accessor :resource_xml_element
    end

    # finds the welo node or creates it if not present
    def welo_node
      node = find_first("//#{self.class.resource_xml_element}", self.class.registered_ns)
      node ||= find_first("//ns:#{self.class.resource_xml_element}", :ns => self.class.registered_ns)
      unless node
        (self << (node = Blather::XMPPNode.new(self.class.resource_xml_element, self.document)))
        node.namespace = self.class.registered_ns
      end
      node
    end

    # finds the XML node corresponding to a given field of the welo node
    def welo_field(sym)
      welo_node.find_first("//ns:#{sym}", :ns => self.registered_ns)
    end

    # removes the old welo_node then stores the resource
    def represents(resource, persp=:default)
      welo_node.remove
      resource.to_xml(self, persp).to_xml
    end
  end
end

