require 'welo'
require 'welo-xmpp/welo_node'
require 'welo-xmpp/message'

module Welo::Xmpp
  module Resource
    include Welo::Resource

    def self.included(mod)
      mod.extend ClassMethods
      mod.extend Welo::Resource::ClassMethods
    end

    # returns an XMPP message, with no body, representing the resource
    def as_xmpp_message(to, persp=:default, body=nil, type=:chat)
      klass = self.class.to_xmpp_message_node(persp)
      obj = klass.new(to, body, type)
      obj.represents(self, persp)
      obj
    end

    # returns a welo node (sort of untied XML node)
    # useful in pubsub
    def as_welo_node(persp=:default)
      klass = self.class.to_welo_node(persp)
      obj = klass.new
      obj.represents(self, persp)
      obj
    end

    # creates an XML node for a blob representing
    # if parent is given, parent will be the parent node of the created node
    def to_xml(parent=nil, persp=:default, id=:default)
      ret = Nokogiri::XML::Builder.new({}, parent) do |xml|
        xml.send(xml_element,{:xmlns => ns(persp)}, :path => File.join('',path(id))) do
          serialized_pairs(persp).each do |name, val|
            case val
            when Welo::Embedder
              val.to.to_xml(xml.parent, persp).to_xml
            when Welo::EmbeddersEnumerator
              xml.send(val.label) do
                val.each do |embedder|
                  embedder.to.to_xml(xml.parent, persp).to_xml
                end
              end
            else
              xml.send(name, val)
            end
          end
        end
      end
      ret
    end

    module ClassMethods
      def xml_element(val=nil)
        (@xml_element ||= val.freeze) || base_path
      end

      def proprietary_ns(val=nil)
        @proprietary_ns ||= val.freeze
      end

      def base_ns
        [NS, proprietary_ns, base_path].compact.join(':').freeze
      end

      def ns(persp=:default)
        [base_ns, persp.to_s].join('#').freeze
      end

      # If we plan to include Blather DSL, Blather DSL will inject methods
      # based on handler_syms into Object. An unfortunate side-effect is that
      # this behaviour will conflict with Nokogiri's XML Builder which rely
      # on method missing to add node names. Hence, this method adds a "_received" suffix.
      #
      # Returns a symbol built with: <method>[_<persp>]_received
      def handler_sym(persp=:default)
        str = if persp == :default
                self.xml_element
              else
                [self.xml_element, persp].map(&:to_s).join('_')
              end
        str = "#{str}_received" 
        str.to_sym
      end

      # storage of XMPP classes
      def xmpp_nodes
        @xmpp_nodes ||= {}
      end

      def to_xmpp_message_node(persp=:default)
        key = [:message, persp]
        klass = unless xmpp_nodes[key]
                  k = Class.new(Message) 
                  k.resource_xml_element = xml_element
                  k.register(handler_sym(persp), xml_element, self.ns(persp))
                  xmpp_nodes[key] = k
                else
                  xmpp_nodes[key]
                end
        klass
      end

      def to_welo_node(persp=:default)
        key = [:welo, persp]
        klass = unless xmpp_nodes[key]
                  k = Class.new(WeloNode) 
                  k.resource_xml_element = xml_element
                  k.register(xml_element, self.ns(persp))
                  xmpp_nodes[key] = k
                else
                  xmpp_nodes[key]
                end
        klass
      end

      def to_xmpp_node(persp=:default, type=:message)
        sym = "to_xmpp_#{type}_node"
        if respond_to? sym
          return send(sym, persp)
        else
          raise ArgumentError, "#{type} is not supported"
        end
      end
    end

    def xml_element
      self.class.xml_element
    end

    def ns(persp=:default)
      self.class.ns(persp)
    end
  end
end

