# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Containers#create
    class ContainerCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute name
      #   Name of the container to create.
      #
      #   @return [String]
      required :name, String

      # @!attribute expires_after
      #   Container expiration time in seconds relative to the 'anchor' time.
      #
      #   @return [OpenAI::Models::ContainerCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::ContainerCreateParams::ExpiresAfter }

      # @!attribute file_ids
      #   IDs of files to copy to the container.
      #
      #   @return [Array<String>, nil]
      optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

      # @!method initialize(name:, expires_after: nil, file_ids: nil, request_options: {})
      #   @param name [String] Name of the container to create.
      #
      #   @param expires_after [OpenAI::Models::ContainerCreateParams::ExpiresAfter] Container expiration time in seconds relative to the 'anchor' time.
      #
      #   @param file_ids [Array<String>] IDs of files to copy to the container.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   Time anchor for the expiration time. Currently only 'last_active_at' is
        #   supported.
        #
        #   @return [Symbol, OpenAI::Models::ContainerCreateParams::ExpiresAfter::Anchor]
        required :anchor, enum: -> { OpenAI::ContainerCreateParams::ExpiresAfter::Anchor }

        # @!attribute minutes
        #
        #   @return [Integer]
        required :minutes, Integer

        # @!method initialize(anchor:, minutes:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::ContainerCreateParams::ExpiresAfter} for more details.
        #
        #   Container expiration time in seconds relative to the 'anchor' time.
        #
        #   @param anchor [Symbol, OpenAI::Models::ContainerCreateParams::ExpiresAfter::Anchor] Time anchor for the expiration time. Currently only 'last_active_at' is supporte
        #
        #   @param minutes [Integer]

        # Time anchor for the expiration time. Currently only 'last_active_at' is
        # supported.
        #
        # @see OpenAI::Models::ContainerCreateParams::ExpiresAfter#anchor
        module Anchor
          extend OpenAI::Internal::Type::Enum

          LAST_ACTIVE_AT = :last_active_at

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
