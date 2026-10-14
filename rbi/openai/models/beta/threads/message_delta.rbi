# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::MessageDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The content of the message in array of text and/or images.
          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Beta::Threads::MessageContentDelta::Variants]
              )
            )
          end
          attr_reader :content

          sig do
            params(
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::ImageFileDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::TextDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::RefusalDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::ImageURLDeltaBlock::OrHash
                  )
                ]
            ).void
          end
          attr_writer :content

          # The entity that produced the message. One of `user` or `assistant`.
          sig do
            returns(
              T.nilable(OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol)
            )
          end
          attr_reader :role

          sig do
            params(
              role: OpenAI::Beta::Threads::MessageDelta::Role::OrSymbol
            ).void
          end
          attr_writer :role

          # The delta containing the fields that have changed on the Message.
          sig do
            params(
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::ImageFileDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::TextDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::RefusalDeltaBlock::OrHash,
                    OpenAI::Beta::Threads::ImageURLDeltaBlock::OrHash
                  )
                ],
              role: OpenAI::Beta::Threads::MessageDelta::Role::OrSymbol
            ).returns(T.attached_class)
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
                content:
                  T::Array[
                    OpenAI::Beta::Threads::MessageContentDelta::Variants
                  ],
                role: OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::MessageDelta::Role)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USER =
              T.let(
                :user,
                OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol
              )
            ASSISTANT =
              T.let(
                :assistant,
                OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Threads::MessageDelta::Role::TaggedSymbol
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
end
