# frozen_string_literal: true

module OpenAI
  module Internal
    # Private registry for OpenAI-owned provider configurations.
    #
    # Provider factories return opaque OpenAI::Provider instances whose public
    # representation does not expose their definition.
    module Provider
      Runtime = Struct.new(:name, :base_url, :prepare_request, keyword_init: true)

      class << self
        # @api private
        def create(definition)
          OpenAI::Provider.send(:new, definition.freeze).freeze
        end

        # @api private
        def name(provider) = definition(provider).name

        # @api private
        def configure(provider) = definition(provider).configure

        private def definition(provider)
          return provider.send(:definition) if provider.instance_of?(OpenAI::Provider)
          raise ArgumentError, "Invalid provider. Providers must be created by an OpenAI provider factory."
        end
      end
    end
  end
end
