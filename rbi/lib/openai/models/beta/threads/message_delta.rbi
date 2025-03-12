# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDelta < OpenAI::BaseModel
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
          def content
          end

          sig do
            params(
              _: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                OpenAI::Models::Beta::Threads::TextDeltaBlock,
                OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
              )
              ]
            )
              .returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                  OpenAI::Models::Beta::Threads::TextDeltaBlock,
                  OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                  OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
                )
                ]
              )
          end
          def content=(_)
          end

          sig { returns(T.nilable(Symbol)) }
          def role
          end

          sig { params(_: Symbol).returns(Symbol) }
          def role=(_)
          end

          sig do
            params(
              content: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileDeltaBlock,
                OpenAI::Models::Beta::Threads::TextDeltaBlock,
                OpenAI::Models::Beta::Threads::RefusalDeltaBlock,
                OpenAI::Models::Beta::Threads::ImageURLDeltaBlock
              )
              ],
              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(content: nil, role: nil)
          end

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
                  role: Symbol
                }
              )
          end
          def to_hash
          end

          class Role < OpenAI::Enum
            abstract!

            USER = :user
            ASSISTANT = :assistant

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
