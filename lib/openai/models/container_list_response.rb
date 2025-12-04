# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Containers#list
    class ContainerListResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Unique identifier for the container.
      #
      #   @return [String]
      required :id, String

      # @!attribute created_at
      #   Unix timestamp (in seconds) when the container was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute name
      #   Name of the container.
      #
      #   @return [String]
      required :name, String

      # @!attribute object
      #   The type of this object.
      #
      #   @return [String]
      required :object, String

      # @!attribute status
      #   Status of the container (e.g., active, deleted).
      #
      #   @return [String]
      required :status, String

      # @!attribute expires_after
      #   The container will expire after this time period. The anchor is the reference
      #   point for the expiration. The minutes is the number of minutes after the anchor
      #   before the container expires.
      #
      #   @return [OpenAI::Models::ContainerListResponse::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::Models::ContainerListResponse::ExpiresAfter }

      # @!attribute last_active_at
      #   Unix timestamp (in seconds) when the container was last active.
      #
      #   @return [Integer, nil]
      optional :last_active_at, Integer

      # @!attribute memory_limit
      #   The memory limit configured for the container.
      #
      #   @return [Symbol, OpenAI::Models::ContainerListResponse::MemoryLimit, nil]
      optional :memory_limit, enum: -> { OpenAI::Models::ContainerListResponse::MemoryLimit }

      # @!method initialize(id:, created_at:, name:, object:, status:, expires_after: nil, last_active_at: nil, memory_limit: nil)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ContainerListResponse} for more details.
      #
      #   @param id [String] Unique identifier for the container.
      #
      #   @param created_at [Integer] Unix timestamp (in seconds) when the container was created.
      #
      #   @param name [String] Name of the container.
      #
      #   @param object [String] The type of this object.
      #
      #   @param status [String] Status of the container (e.g., active, deleted).
      #
      #   @param expires_after [OpenAI::Models::ContainerListResponse::ExpiresAfter] The container will expire after this time period.
      #
      #   @param last_active_at [Integer] Unix timestamp (in seconds) when the container was last active.
      #
      #   @param memory_limit [Symbol, OpenAI::Models::ContainerListResponse::MemoryLimit] The memory limit configured for the container.

      # @see OpenAI::Models::ContainerListResponse#expires_after
      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   The reference point for the expiration.
        #
        #   @return [Symbol, OpenAI::Models::ContainerListResponse::ExpiresAfter::Anchor, nil]
        optional :anchor, enum: -> { OpenAI::Models::ContainerListResponse::ExpiresAfter::Anchor }

        # @!attribute minutes
        #   The number of minutes after the anchor before the container expires.
        #
        #   @return [Integer, nil]
        optional :minutes, Integer

        # @!method initialize(anchor: nil, minutes: nil)
        #   The container will expire after this time period. The anchor is the reference
        #   point for the expiration. The minutes is the number of minutes after the anchor
        #   before the container expires.
        #
        #   @param anchor [Symbol, OpenAI::Models::ContainerListResponse::ExpiresAfter::Anchor] The reference point for the expiration.
        #
        #   @param minutes [Integer] The number of minutes after the anchor before the container expires.

        # The reference point for the expiration.
        #
        # @see OpenAI::Models::ContainerListResponse::ExpiresAfter#anchor
        module Anchor
          extend OpenAI::Internal::Type::Enum

          LAST_ACTIVE_AT = :last_active_at

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # The memory limit configured for the container.
      #
      # @see OpenAI::Models::ContainerListResponse#memory_limit
      module MemoryLimit
        extend OpenAI::Internal::Type::Enum

        MEMORY_LIMIT_1G = :"1g"
        MEMORY_LIMIT_4G = :"4g"
        MEMORY_LIMIT_16G = :"16g"
        MEMORY_LIMIT_64G = :"64g"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
