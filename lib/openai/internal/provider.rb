# frozen_string_literal: true

module OpenAI
  module Internal
    # Private registry for OpenAI-owned provider configurations.
    #
    # Provider factories return opaque handles whose public representation does
    # not expose their definition. The handle constructor is private so arbitrary
    # objects cannot imitate supported providers.
    module Provider
      Handle = Class.new do
        def initialize(definition) = @definition = definition

        def inspect = "#<OpenAI::Provider>"

        attr_reader(:definition)
        private(:definition)

        private_class_method :new, :allocate
      end

      Runtime = Struct.new(:name, :base_url, :prepare_request, keyword_init: true)

      class << self
        # @api private
        def create(definition)
          Handle.send(:new, definition.freeze).freeze
        end

        # @api private
        def name(provider) = definition(provider).name

        # @api private
        def configure(provider) = definition(provider).configure

        private def definition(provider)
          return provider.send(:definition) if provider.instance_of?(Handle)
          raise OpenAI::Errors::Error,
                "Invalid provider. Providers must be created by an OpenAI provider factory."
        end
      end
    end
  end
end
