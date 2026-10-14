# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitThreadUserMessageItem = ChatKit::ChatKitThreadUserMessageItem

      module ChatKit
        class ChatKitThreadUserMessageItem < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the thread item.
          sig { returns(String) }
          attr_accessor :id

          # Attachments associated with the user message. Defaults to an empty list.
          sig { returns(T::Array[OpenAI::Beta::ChatKit::ChatKitAttachment]) }
          attr_accessor :attachments

          # Ordered content elements supplied by the user.
          sig do
            returns(
              T::Array[
                OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::Variants
              ]
            )
          end
          attr_accessor :content

          # Unix timestamp (in seconds) for when the item was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Inference overrides applied to the message. Defaults to null when unset.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions
              )
            )
          end
          attr_reader :inference_options

          sig do
            params(
              inference_options:
                T.nilable(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::OrHash
                )
            ).void
          end
          attr_writer :inference_options

          # Type discriminator that is always `chatkit.thread_item`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Identifier of the parent thread.
          sig { returns(String) }
          attr_accessor :thread_id

          sig { returns(Symbol) }
          attr_accessor :type

          # User-authored messages within a thread.
          sig do
            params(
              id: String,
              attachments:
                T::Array[OpenAI::Beta::ChatKit::ChatKitAttachment::OrHash],
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText::OrHash
                  )
                ],
              created_at: Integer,
              inference_options:
                T.nilable(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::OrHash
                ),
              thread_id: String,
              object: Symbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier of the thread item.
            id:,
            # Attachments associated with the user message. Defaults to an empty list.
            attachments:,
            # Ordered content elements supplied by the user.
            content:,
            # Unix timestamp (in seconds) for when the item was created.
            created_at:,
            # Inference overrides applied to the message. Defaults to null when unset.
            inference_options:,
            # Identifier of the parent thread.
            thread_id:,
            # Type discriminator that is always `chatkit.thread_item`.
            object: :"chatkit.thread_item",
            type: :"chatkit.user_message"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                attachments: T::Array[OpenAI::Beta::ChatKit::ChatKitAttachment],
                content:
                  T::Array[
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::Variants
                  ],
                created_at: Integer,
                inference_options:
                  T.nilable(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions
                  ),
                object: Symbol,
                thread_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Content blocks that comprise a user message.
          module Content
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText,
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText
                )
              end

            class InputText < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Plain-text content supplied by the user.
              sig { returns(String) }
              attr_accessor :text

              # Type discriminator that is always `input_text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Text block that a user contributed to the thread.
              sig do
                params(text: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(
                # Plain-text content supplied by the user.
                text:,
                # Type discriminator that is always `input_text`.
                type: :input_text
              )
              end

              sig { override.returns({ text: String, type: Symbol }) }
              def to_hash
              end
            end

            class QuotedText < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Quoted text content.
              sig { returns(String) }
              attr_accessor :text

              # Type discriminator that is always `quoted_text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Quoted snippet that the user referenced in their message.
              sig do
                params(text: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(
                # Quoted text content.
                text:,
                # Type discriminator that is always `quoted_text`.
                type: :quoted_text
              )
              end

              sig { override.returns({ text: String, type: Symbol }) }
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::Variants
                ]
              )
            end
            def self.variants
            end
          end

          class InferenceOptions < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions,
                  OpenAI::Internal::AnyHash
                )
              end

            # Model name that generated the response. Defaults to null when using the session
            # default.
            sig { returns(T.nilable(String)) }
            attr_accessor :model

            # Preferred tool to invoke. Defaults to null when ChatKit should auto-select.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice
                )
              )
            end
            attr_reader :tool_choice

            sig do
              params(
                tool_choice:
                  T.nilable(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice::OrHash
                  )
              ).void
            end
            attr_writer :tool_choice

            # Inference overrides applied to the message. Defaults to null when unset.
            sig do
              params(
                model: T.nilable(String),
                tool_choice:
                  T.nilable(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice::OrHash
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # Model name that generated the response. Defaults to null when using the session
              # default.
              model:,
              # Preferred tool to invoke. Defaults to null when ChatKit should auto-select.
              tool_choice:
            )
            end

            sig do
              override.returns(
                {
                  model: T.nilable(String),
                  tool_choice:
                    T.nilable(
                      OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice
                    )
                }
              )
            end
            def to_hash
            end

            class ToolChoice < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Identifier of the requested tool.
              sig { returns(String) }
              attr_accessor :id

              # Preferred tool to invoke. Defaults to null when ChatKit should auto-select.
              sig { params(id: String).returns(T.attached_class) }
              def self.new(
                # Identifier of the requested tool.
                id:
              )
              end

              sig { override.returns({ id: String }) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
