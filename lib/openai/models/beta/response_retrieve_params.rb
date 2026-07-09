# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Responses#retrieve
      #
      # @see OpenAI::Resources::Beta::Responses#retrieve_streaming
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute response_id
        #
        #   @return [String]
        required :response_id, String

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaResponseIncludable] }

        # @!attribute include_obfuscation
        #   When true, stream obfuscation will be enabled. Stream obfuscation adds random
        #   characters to an `obfuscation` field on streaming delta events to normalize
        #   payload sizes as a mitigation to certain side-channel attacks. These obfuscation
        #   fields are included by default, but add a small amount of overhead to the data
        #   stream. You can set `include_obfuscation` to false to optimize for bandwidth if
        #   you trust the network links between your application and the OpenAI API.
        #
        #   @return [Boolean, nil]
        optional :include_obfuscation, OpenAI::Internal::Type::Boolean

        # @!attribute starting_after
        #   The sequence number of the event after which to start streaming.
        #
        #   @return [Integer, nil]
        optional :starting_after, Integer

        # @!attribute betas
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>, nil]
        optional :betas, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::ResponseRetrieveParams::Beta] }

        # @!method initialize(response_id:, include: nil, include_obfuscation: nil, starting_after: nil, betas: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ResponseRetrieveParams} for more details.
        #
        #   @param response_id [String]
        #
        #   @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>] Additional fields to include in the response. See the `include`
        #
        #   @param include_obfuscation [Boolean] When true, stream obfuscation will be enabled. Stream obfuscation adds
        #
        #   @param starting_after [Integer] The sequence number of the event after which to start streaming.
        #
        #   @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>]
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        module Beta
          extend OpenAI::Internal::Type::Enum

          RESPONSES_MULTI_AGENT_V1 = :"responses_multi_agent=v1"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
