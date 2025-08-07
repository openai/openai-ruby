# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#retrieve
      #
      # @see OpenAI::Resources::Responses#retrieve_streaming
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] }

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

        # @!method initialize(include: nil, include_obfuscation: nil, starting_after: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseRetrieveParams} for more details.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
        #
        #   @param include_obfuscation [Boolean] When true, stream obfuscation will be enabled. Stream obfuscation adds
        #
        #   @param starting_after [Integer] The sequence number of the event after which to start streaming.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
