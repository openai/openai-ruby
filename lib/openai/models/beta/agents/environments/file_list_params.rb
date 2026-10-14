# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Files#list
          class FileListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute environment_id
            #
            #   @return [String]
            required :environment_id, String

            # @!attribute limit
            #   The maximum number of files to return, between 1 and 100.
            #
            #   @return [Integer, nil]
            optional :limit, Integer, nil?: true

            # @!attribute order
            #   Sort by case-sensitive path components. Defaults to descending.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::Environments::FileListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Beta::Agents::Environments::FileListParams::Order }

            # @!attribute page
            #   The opaque token from the previous page. Keep the same path, order, and limit.
            #
            #   @return [String, nil]
            optional :page, String

            # @!attribute path
            #   Restrict the listing to this absolute workspace directory.
            #
            #   @return [String, nil]
            optional :path, String, nil?: true

            # @!method initialize(environment_id:, limit: nil, order: nil, page: nil, path: nil, request_options: {})
            #   @param environment_id [String]
            #
            #   @param limit [Integer, nil]
            #     The maximum number of files to return, between 1 and 100.
            #
            #   @param order [Symbol, OpenAI::Models::Beta::Agents::Environments::FileListParams::Order]
            #     Sort by case-sensitive path components. Defaults to descending.
            #
            #   @param page [String]
            #     The opaque token from the previous page. Keep the same path, order, and limit.
            #
            #   @param path [String, nil]
            #     Restrict the listing to this absolute workspace directory.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Sort by case-sensitive path components. Defaults to descending.
            module Order
              extend OpenAI::Internal::Type::Enum

              # Returns resources in ascending order.
              ASC = :asc

              # Returns resources in descending order.
              DESC = :desc

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
