# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepListParams < OpenAI::BaseModel
            # @!parse
            #   extend OpenAI::RequestParameters::Converter
            include OpenAI::RequestParameters

            # @!attribute thread_id
            #
            #   @return [String]
            required :thread_id, String

            # @!attribute [r] after
            #   A cursor for use in pagination. `after` is an object ID that defines your place
            #     in the list. For instance, if you make a list request and receive 100 objects,
            #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #     fetch the next page of the list.
            #
            #   @return [String, nil]
            optional :after, String

            # @!parse
            #   # @return [String]
            #   attr_writer :after

            # @!attribute [r] before
            #   A cursor for use in pagination. `before` is an object ID that defines your place
            #     in the list. For instance, if you make a list request and receive 100 objects,
            #     starting with obj_foo, your subsequent call can include before=obj_foo in order
            #     to fetch the previous page of the list.
            #
            #   @return [String, nil]
            optional :before, String

            # @!parse
            #   # @return [String]
            #   attr_writer :before

            # @!attribute [r] include
            #   A list of additional fields to include in the response. Currently the only
            #     supported value is `step_details.tool_calls[*].file_search.results[*].content`
            #     to fetch the file search result content.
            #
            #     See the
            #     [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #     for more information.
            #
            #   @return [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>, nil]
            optional :include, -> { OpenAI::ArrayOf[enum: OpenAI::Models::Beta::Threads::Runs::RunStepInclude] }

            # @!parse
            #   # @return [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   attr_writer :include

            # @!attribute [r] limit
            #   A limit on the number of objects to be returned. Limit can range between 1 and
            #     100, and the default is 20.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!parse
            #   # @return [Integer]
            #   attr_writer :limit

            # @!attribute [r] order
            #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #     order and `desc` for descending order.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Models::Beta::Threads::Runs::StepListParams::Order }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order]
            #   attr_writer :order

            # @!parse
            #   # @param thread_id [String]
            #   # @param after [String]
            #   # @param before [String]
            #   # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   # @param limit [Integer]
            #   # @param order [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order]
            #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
            #   #
            #   def initialize(thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {}, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            #
            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
            class Order < OpenAI::Enum
              ASC = :asc
              DESC = :desc

              finalize!
            end
          end
        end
      end
    end
  end
end
