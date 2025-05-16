# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @see OpenAI::Resources::Beta::Threads::Runs::Steps#list
          class StepListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute thread_id
            #
            #   @return [String]
            required :thread_id, String

            # @!attribute after
            #   A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute before
            #   A cursor for use in pagination. `before` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   starting with obj_foo, your subsequent call can include before=obj_foo in order
            #   to fetch the previous page of the list.
            #
            #   @return [String, nil]
            optional :before, String

            # @!attribute include
            #   A list of additional fields to include in the response. Currently the only
            #   supported value is `step_details.tool_calls[*].file_search.results[*].content`
            #   to fetch the file search result content.
            #
            #   See the
            #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   for more information.
            #
            #   @return [Array<Symbol, OpenAI::Beta::Threads::Runs::RunStepInclude>, nil]
            optional :include,
                     -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::Threads::Runs::RunStepInclude] }

            # @!attribute limit
            #   A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute order
            #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
            #
            #   @return [Symbol, OpenAI::Beta::Threads::Runs::StepListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Beta::Threads::Runs::StepListParams::Order }

            # @!method initialize(thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Threads::Runs::StepListParams} for more details.
            #
            #   @param thread_id [String]
            #
            #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            #   @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
            #
            #   @param include [Array<Symbol, OpenAI::Beta::Threads::Runs::RunStepInclude>] A list of additional fields to include in the response. Currently the only suppo
            #
            #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
            #
            #   @param order [Symbol, OpenAI::Beta::Threads::Runs::StepListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
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
end
