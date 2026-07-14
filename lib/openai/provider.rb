# frozen_string_literal: true

module OpenAI
  # Opaque configuration for an OpenAI-supported third-party provider.
  #
  # Provider instances are created by factories in OpenAI::Providers.
  class Provider
    # @api private
    def initialize(definition) = @definition = definition

    def inspect = "#<OpenAI::Provider>"

    attr_reader(:definition)
    private(:definition)

    private_class_method :new, :allocate
  end
end
