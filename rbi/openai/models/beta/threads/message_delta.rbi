# typed: strong

module OpenAI
  module Models

    module Beta

      module Threads

        class MessageDelta < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Threads::MessageDelta,
              OpenAI::Internal::AnyHash
            )
          end

          # The content of the message in array of text and/or images.
          sig { returns(T.nilable(T::Array[OpenAI::Beta::Threads::MessageContentDelta::Variants])) }
          attr_reader :content

          sig {
            params(
              content: T::Array[
                T.any(
                  OpenAI::Beta::Threads::ImageFileDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::TextDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::RefusalDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::ImageURLDeltaBlock::OrHash
                )
              ]
            )
              .void
          }
          attr_writer :content

          # The entity that produced the message. One of `user` or `assistant`.
          sig { returns(T.nilable(OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol)) }
          attr_reader :role

          sig { params(role: OpenAI::Beta::Threads::MessageDelta::Role::OrSymbol).void }
          attr_writer :role

          # The delta containing the fields that have changed on the Message.
          sig do
            params(

              content: T::Array[
                T.any(
                  OpenAI::Beta::Threads::ImageFileDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::TextDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::RefusalDeltaBlock::OrHash,
                  OpenAI::Beta::Threads::ImageURLDeltaBlock::OrHash
                )
              ],

              role: OpenAI::Beta::Threads::MessageDelta::Role::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The content of the message in array of text and/or images.
            content: nil,

            # The entity that produced the message. One of `user` or `assistant`.

            role: nil
          )
          end

          sig do
            override.returns(
              {
                content: T::Array[OpenAI::Beta::Threads::MessageContentDelta::Variants],
                role: OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Threads::MessageDelta::Role) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USER = T.let(:user, OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol)
            ASSISTANT = T.let(:assistant, OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
