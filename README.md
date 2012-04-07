# Welo::Xmpp

Welo::Xmpp is a gem to easily send and receive XMPP stanzas carrying
Welo resources.
Welo::Xmpp uses the Blather library to perform all the XMPP operation, hence

Extending Blather is kind of cumbersome.  Welo::Xmpp should be seen as a
simple helper for this case.  This library does not monkey patch Blather but
uses subclasses of Blather stanzas.

on the emitter side you can:
- serialize a Welo resource to an XML blob

on the receiver side you can:
- setup Blather handlers on specific resources/perspective
(note that resources are not deserialized)


## Installation

Add this line to your application's Gemfile:

    gem 'welo-xmpp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install welo-xmpp

## Usage

Prior knowledge of Blather is mandatory.

See the sample directory for how to work with Welo::Xmpp.

Note that you need to setup JIDs for two bots which are subscribed to each
other. You also need to modify the samples/emitter.rb file to give the JID for
the receiver-side of the example in the RECEIVER constant.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
