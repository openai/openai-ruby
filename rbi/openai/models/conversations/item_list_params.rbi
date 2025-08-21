# typed: strong

module OpenAI
  module Models
    module Conversations
      class ItemListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ItemListParams,
              OpenAI::Internal::AnyHash
            )
          end

        # An item ID to list items after, used in pagination.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Specify additional output data to include in the model response. Currently
        # supported values are:
        #
        # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #   in code interpreter tool call items.
        # - `computer_call_output.output.image_url`: Include image urls from the computer
        #   call output.
        # - `file_search_call.results`: Include the search results of the file search tool
        #   call.
        # - `message.input_image.image_url`: Include image urls from the input message.
        # - `message.output_text.logprobs`: Include logprobs with assistant messages.
        # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #   tokens in reasoning item outputs. This enables reasoning items to be used in
        #   multi-turn conversations when using the Responses API statelessly (like when
        #   the `store` parameter is set to `false`, or when an organization is enrolled
        #   in the zero data retention program).
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
          ).void
        end
        attr_writer :include

        # A limit on the number of objects to be returned. Limit can range between 1 and
        # 100, and the default is 20.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # The order to return the input items in. Default is `desc`.
        #
        # - `asc`: Return the input items in ascending order.
        # - `desc`: Return the input items in descending order.
        sig do
          returns(
            T.nilable(OpenAI::Conversations::ItemListParams::Order::OrSymbol)
          )
        end
        attr_reader :order

        sig do
          params(
            order: OpenAI::Conversations::ItemListParams::Order::OrSymbol
          ).void
        end
        attr_writer :order

        sig do
          params(
            after: String,
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Conversations::ItemListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # An item ID to list items after, used in pagination.
          after: nil,
          # Specify additional output data to include in the model response. Currently
          # supported values are:
          #
          # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
          #   in code interpreter tool call items.
          # - `computer_call_output.output.image_url`: Include image urls from the computer
          #   call output.
          # - `file_search_call.results`: Include the search results of the file search tool
          #   call.
          # - `message.input_image.image_url`: Include image urls from the input message.
          # - `message.output_text.logprobs`: Include logprobs with assistant messages.
          # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
          #   tokens in reasoning item outputs. This enables reasoning items to be used in
          #   multi-turn conversations when using the Responses API statelessly (like when
          #   the `store` parameter is set to `false`, or when an organization is enrolled
          #   in the zero data retention program).
          include: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          limit: nil,
          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          order: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              include:
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
              limit: Integer,
              order: OpenAI::Conversations::ItemListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The order to return the input items in. Default is `desc`.
        #
        # - `asc`: Return the input items in ascending order.
        # - `desc`: Return the input items in descending order.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Conversations::ItemListParams::Order)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC =
            T.let(
              :asc,
              OpenAI::Conversations::ItemListParams::Order::TaggedSymbol
            )
          DESC =
            T.let(
              :desc,
              OpenAI::Conversations::ItemListParams::Order::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Conversations::ItemListParams::Order::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
