# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The unique identifier of the reasoning content.
        sig { returns(String) }
        attr_accessor :id

        # Reasoning text contents.
        sig do
          returns(T::Array[OpenAI::Responses::ResponseReasoningItem::Summary])
        end
        attr_accessor :summary

        # The type of the object. Always `reasoning`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The encrypted content of the reasoning item - populated when a response is
        # generated with `reasoning.encrypted_content` in the `include` parameter.
        sig { returns(T.nilable(String)) }
        attr_accessor :encrypted_content

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status: OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # A description of the chain of thought used by a reasoning model while generating
        # a response. Be sure to include these items in your `input` to the Responses API
        # for subsequent turns of a conversation if you are manually
        # [managing context](https://platform.openai.com/docs/guides/conversation-state).
        sig do
          params(
            id: String,
            summary:
              T::Array[
                OpenAI::Responses::ResponseReasoningItem::Summary::OrHash
              ],
            encrypted_content: T.nilable(String),
            status: OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the reasoning content.
          id:,
          # Reasoning text contents.
          summary:,
          # The encrypted content of the reasoning item - populated when a response is
          # generated with `reasoning.encrypted_content` in the `include` parameter.
          encrypted_content: nil,
          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status: nil,
          # The type of the object. Always `reasoning`.
          type: :reasoning
        )
        end

        sig do
          override.returns(
            {
              id: String,
              summary:
                T::Array[OpenAI::Responses::ResponseReasoningItem::Summary],
              type: Symbol,
              encrypted_content: T.nilable(String),
              status: OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Summary < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # A short summary of the reasoning used by the model when generating the response.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # A short summary of the reasoning used by the model when generating the response.
            text:,
            # The type of the object. Always `summary_text`.
            type: :summary_text
          )
          end

          sig { override.returns({ text: String, type: Symbol }) }
          def to_hash
          end
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseReasoningItem::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseReasoningItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseReasoningItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseReasoningItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseReasoningItem::Status::TaggedSymbol
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
