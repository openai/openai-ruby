# typed: strong

module OpenAI
  module Models
    module Conversations
      class Message < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Conversations::Message, OpenAI::Internal::AnyHash)
          end

        # The unique ID of the message.
        sig { returns(String) }
        attr_accessor :id

        # The content of the message
        sig do
          returns(T::Array[OpenAI::Conversations::Message::Content::Variants])
        end
        attr_accessor :content

        # The role of the message. One of `unknown`, `user`, `assistant`, `system`,
        # `critic`, `discriminator`, `developer`, or `tool`.
        sig { returns(OpenAI::Conversations::Message::Role::TaggedSymbol) }
        attr_accessor :role

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(OpenAI::Conversations::Message::Status::TaggedSymbol) }
        attr_accessor :status

        # The type of the message. Always set to `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A message to or from the model.
        sig do
          params(
            id: String,
            content:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseInputText::OrHash,
                  OpenAI::Responses::ResponseOutputText::OrHash,
                  OpenAI::Conversations::TextContent::OrHash,
                  OpenAI::Conversations::SummaryTextContent::OrHash,
                  OpenAI::Conversations::Message::Content::ReasoningText::OrHash,
                  OpenAI::Responses::ResponseOutputRefusal::OrHash,
                  OpenAI::Responses::ResponseInputImage::OrHash,
                  OpenAI::Conversations::ComputerScreenshotContent::OrHash,
                  OpenAI::Responses::ResponseInputFile::OrHash
                )
              ],
            role: OpenAI::Conversations::Message::Role::OrSymbol,
            status: OpenAI::Conversations::Message::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the message.
          id:,
          # The content of the message
          content:,
          # The role of the message. One of `unknown`, `user`, `assistant`, `system`,
          # `critic`, `discriminator`, `developer`, or `tool`.
          role:,
          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status:,
          # The type of the message. Always set to `message`.
          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content:
                T::Array[OpenAI::Conversations::Message::Content::Variants],
              role: OpenAI::Conversations::Message::Role::TaggedSymbol,
              status: OpenAI::Conversations::Message::Status::TaggedSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # A content part that makes up an input or output item.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseInputText,
                OpenAI::Responses::ResponseOutputText,
                OpenAI::Conversations::TextContent,
                OpenAI::Conversations::SummaryTextContent,
                OpenAI::Conversations::Message::Content::ReasoningText,
                OpenAI::Responses::ResponseOutputRefusal,
                OpenAI::Responses::ResponseInputImage,
                OpenAI::Conversations::ComputerScreenshotContent,
                OpenAI::Responses::ResponseInputFile
              )
            end

          class ReasoningText < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Conversations::Message::Content::ReasoningText,
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

          sig do
            override.returns(
              T::Array[OpenAI::Conversations::Message::Content::Variants]
            )
          end
          def self.variants
          end
        end

        # The role of the message. One of `unknown`, `user`, `assistant`, `system`,
        # `critic`, `discriminator`, `developer`, or `tool`.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Conversations::Message::Role) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          UNKNOWN =
            T.let(:unknown, OpenAI::Conversations::Message::Role::TaggedSymbol)
          USER =
            T.let(:user, OpenAI::Conversations::Message::Role::TaggedSymbol)
          ASSISTANT =
            T.let(
              :assistant,
              OpenAI::Conversations::Message::Role::TaggedSymbol
            )
          SYSTEM =
            T.let(:system, OpenAI::Conversations::Message::Role::TaggedSymbol)
          CRITIC =
            T.let(:critic, OpenAI::Conversations::Message::Role::TaggedSymbol)
          DISCRIMINATOR =
            T.let(
              :discriminator,
              OpenAI::Conversations::Message::Role::TaggedSymbol
            )
          DEVELOPER =
            T.let(
              :developer,
              OpenAI::Conversations::Message::Role::TaggedSymbol
            )
          TOOL =
            T.let(:tool, OpenAI::Conversations::Message::Role::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Conversations::Message::Role::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Conversations::Message::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Conversations::Message::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Conversations::Message::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Conversations::Message::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Conversations::Message::Status::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
