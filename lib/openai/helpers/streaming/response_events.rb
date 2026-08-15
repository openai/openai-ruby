# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      # @api private
      #
      # Azure may emit a transport-level heartbeat while a Responses request is still
      # running. Keep that undocumented event raw instead of asking the generated union
      # to infer one of its known API event models.
      module KeepAliveEventCoercion
        # @api private
        #
        # @param value [Object]
        # @param state [Hash{Symbol=>Object}]
        # @return [Object]
        def coerce(value, state:)
          type = value.fetch(:type) { value["type"] } if value.is_a?(Hash)
          case type
          in "keepalive" | :keepalive
            OpenAI::Internal::Type::Unknown.coerce(value, state: state)
          else
            super
          end
        end
      end

      class ResponseTextDeltaEvent < OpenAI::Models::Responses::ResponseTextDeltaEvent
        required :snapshot, String
      end

      class ResponseTextDoneEvent < OpenAI::Models::Responses::ResponseTextDoneEvent
        optional :parsed, Object
      end

      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
        required :snapshot, String
      end

      class ResponseCompletedEvent < OpenAI::Models::Responses::ResponseCompletedEvent
        required :response, OpenAI::Models::Responses::Response
      end

      OpenAI::Models::Responses::ResponseStreamEvent.extend(KeepAliveEventCoercion)
      OpenAI::Models::Beta::BetaResponseStreamEvent.extend(KeepAliveEventCoercion)

      private_constant :KeepAliveEventCoercion
    end
  end
end
