# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      # @see OpenAI::Resources::Skills::Versions#list
      class VersionListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   The skill version ID to start after.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   Number of versions to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute order
        #   Sort order of results by version number.
        #
        #   @return [Symbol, OpenAI::Models::Skills::VersionListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Skills::VersionListParams::Order }

        # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
        #   @param after [String] The skill version ID to start after.
        #
        #   @param limit [Integer] Number of versions to retrieve.
        #
        #   @param order [Symbol, OpenAI::Models::Skills::VersionListParams::Order] Sort order of results by version number.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Sort order of results by version number.
        module Order
          extend OpenAI::Internal::Type::Enum

          ASC = :asc
          DESC = :desc

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
