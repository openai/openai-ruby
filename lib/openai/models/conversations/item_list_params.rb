# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # @see OpenAI::Resources::Conversations::Items#list
      class ItemListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   An item ID to list items after, used in pagination.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute include
        #   Specify additional output data to include in the model response. Currently
        #   supported values are:
        #
        #   - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #     in code interpreter tool call items.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `message.output_text.logprobs`: Include logprobs with assistant messages.
        #   - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #     tokens in reasoning item outputs. This enables reasoning items to be used in
        #     multi-turn conversations when using the Responses API statelessly (like when
        #     the `store` parameter is set to `false`, or when an organization is enrolled
        #     in the zero data retention program).
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] }

        # @!attribute limit
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute order
        #   The order to return the input items in. Default is `desc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        #
        #   @return [Symbol, OpenAI::Models::Conversations::ItemListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Conversations::ItemListParams::Order }

        # @!method initialize(after: nil, include: nil, limit: nil, order: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::ItemListParams} for more details.
        #
        #   @param after [String] An item ID to list items after, used in pagination.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Specify additional output data to include in the model response. Currently
        #
        #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between
        #
        #   @param order [Symbol, OpenAI::Models::Conversations::ItemListParams::Order] The order to return the input items in. Default is `desc`.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The order to return the input items in. Default is `desc`.
        #
        # - `asc`: Return the input items in ascending order.
        # - `desc`: Return the input items in descending order.
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
