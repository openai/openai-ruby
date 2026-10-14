# frozen_string_literal: true

require_relative "unknown_stream_event"

module OpenAI
  module Helpers
    module Streaming
      # @api private
      class ResponseEventDecoder
        def initialize(model:)
          @model = model
          return unless response_stream_model?

          @known_types = model.variants.to_h do |variant|
            type = variant.known_fields.fetch(:type).fetch(:const)
            [type.to_s, true]
          end
        end

        def decode(data)
          if unknown_response_event?(data)
            UnknownStreamEvent.new(data: data)
          else
            OpenAI::Internal::Type::Converter.coerce(@model, data)
          end
        end

        private

        def response_stream_model?
          @model.equal?(OpenAI::Models::Responses::ResponseStreamEvent) ||
            @model.equal?(OpenAI::Models::Beta::BetaResponseStreamEvent)
        end

        def unknown_response_event?(data)
          return false unless @known_types && data.is_a?(Hash)

          type = data[:type]
          (type.is_a?(String) || type.is_a?(Symbol)) && !@known_types.key?(type.to_s)
        end
      end
    end
  end
end
