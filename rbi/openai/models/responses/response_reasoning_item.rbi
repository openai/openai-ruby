# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningItem,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the reasoning content.
        sig { returns(String) }
        attr_accessor :id

        # Reasoning summary content.
        sig do
          returns(T::Array[OpenAI::Responses::ResponseReasoningItem::Summary])
        end
        attr_accessor :summary

        # The type of the object. Always `reasoning`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Reasoning text content.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Responses::ResponseReasoningItem::Content]
            )
          )
        end
        attr_reader :content

        sig do
          params(
            content:
              T::Array[
                OpenAI::Responses::ResponseReasoningItem::Content::OrHash
              ]
          ).void
        end
        attr_writer :content

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
            content:
              T::Array[
                OpenAI::Responses::ResponseReasoningItem::Content::OrHash
              ],
            encrypted_content: T.nilable(String),
            status: OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the reasoning content.
          id:,
          # Reasoning summary content.
          summary:,
          # Reasoning text content.
          content: nil,
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
              content:
                T::Array[OpenAI::Responses::ResponseReasoningItem::Content],
              encrypted_content: T.nilable(String),
              status: OpenAI::Responses::ResponseReasoningItem::Status::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Summary < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseReasoningItem::Summary,
                OpenAI::Internal::AnyHash
              )
            end

          # A summary of the reasoning output from the model so far.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A summary text from the model.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # A summary of the reasoning output from the model so far.
            text:,
            # The type of the object. Always `summary_text`.
            type: :summary_text
          )
          end

          sig { override.returns({ text: String, type: Symbol }) }
          def to_hash
          end
        end

        class Content < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseReasoningItem::Content,
                OpenAI::Internal::AnyHash
              )
            end

          # The reasoning text from the model.
          sig { returns(String) }
          attr_accessor :text

          # The type of the reasoning text. Always `reasoning_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Reasoning text from the model.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # The reasoning text from the model.
            text:,
            # The type of the reasoning text. Always `reasoning_text`.
            type: :reasoning_text
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
