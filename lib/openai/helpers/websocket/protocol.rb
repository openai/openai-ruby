# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared helpers for discriminated JSON WebSocket events.
    #
    # @api private
    module Protocol
      private def discriminator_values(union)
        union.variants.to_h do |variant|
          value = variant.fields.fetch(:type).fetch(:const)
          [value.to_s, true]
        end
      end

      private def event_type(event, message:)
        raise ArgumentError, message unless event.is_a?(Hash)

        type = event[:type]
        return type if type.is_a?(String) || type.is_a?(Symbol)

        raise ArgumentError, message
      end
    end
  end
end
