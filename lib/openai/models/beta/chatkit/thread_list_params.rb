# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        # @see OpenAI::Resources::Beta::ChatKit::Threads#list
        class ThreadListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   List items created after this thread item ID. Defaults to null for the first
          #   page.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute before
          #   List items created before this thread item ID. Defaults to null for the newest
          #   results.
          #
          #   @return [String, nil]
          optional :before, String

          # @!attribute limit
          #   Maximum number of thread items to return. Defaults to 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Sort order for results by creation time. Defaults to `desc`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ThreadListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::ChatKit::ThreadListParams::Order }

          # @!attribute user
          #   Filter threads that belong to this user identifier. Defaults to null to return
          #   all users.
          #
          #   @return [String, nil]
          optional :user, String

          # @!method initialize(after: nil, before: nil, limit: nil, order: nil, user: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::ThreadListParams} for more details.
          #
          #   @param after [String] List items created after this thread item ID. Defaults to null for the first pag
          #
          #   @param before [String] List items created before this thread item ID. Defaults to null for the newest r
          #
          #   @param limit [Integer] Maximum number of thread items to return. Defaults to 20.
          #
          #   @param order [Symbol, OpenAI::Models::Beta::ChatKit::ThreadListParams::Order] Sort order for results by creation time. Defaults to `desc`.
          #
          #   @param user [String] Filter threads that belong to this user identifier. Defaults to null to return a
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order for results by creation time. Defaults to `desc`.
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
end
