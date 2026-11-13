# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Events#stream_streaming
          class EventStreamParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute session_id
            #
            #   @return [String]
            required :session_id, String

            # @!attribute include_obfuscation
            #   Whether to include obfuscation padding in events on this connection. Defaults to
            #   `true`.
            #
            #   @return [Boolean, nil]
            optional :include_obfuscation, OpenAI::Internal::Type::Boolean

            # @!method initialize(session_id:, include_obfuscation: nil, request_options: {})
            #   @param session_id [String]
            #
            #   @param include_obfuscation [Boolean]
            #     Whether to include obfuscation padding in events on this connection. Defaults to
            #     `true`.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
