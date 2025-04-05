# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDelta < OpenAI::Internal::Type::BaseModel
          # The content of the message in array of text and/or images.
          sig do
            returns(
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                    OpenAI::Models::Beta::Threads::TextDeltaBlock,
                    OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                    OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
                  )
                ]
              )
            )
          end
          attr_reader :content

          sig do
            params(
              content: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::TextDeltaBlock,
                  OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                  OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
                )
              ]
            )
              .void
          end
          attr_writer :content

          # The entity that produced the message. One of `user` or `assistant`.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol)) }
          attr_reader :role

          sig { params(role: OpenAI::Models::Beta::Threads::MessageDelta::Role::OrSymbol).void }
          attr_writer :role

          # The delta containing the fields that have changed on the Message.
          sig do
            params(
              content: T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::TextDeltaBlock,
                  OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                  OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
                )
              ],
              role: OpenAI::Models::Beta::Threads::MessageDelta::Role::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(content: nil, role: nil); end

          sig do
            override
              .returns(
                {
                  content: T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                      OpenAI::Models::Beta::Threads::TextDeltaBlock,
                      OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                      OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
                    )
                  ],
                  role: OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol
                }
              )
          end
          def to_hash; end

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::MessageDelta::Role) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol)
            ASSISTANT = T.let(:assistant, OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::MessageDelta::Role::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end
