# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDeltaBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::TextDeltaBlock,
                OpenAI::Internal::AnyHash
              )
            end

          # The index of the content part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(OpenAI::Beta::Threads::TextDelta)) }
          attr_reader :text

          sig { params(text: OpenAI::Beta::Threads::TextDelta::OrHash).void }
          attr_writer :text

          # The text content that is part of a message.
          sig do
            params(
              index: Integer,
              text: OpenAI::Beta::Threads::TextDelta::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part in the message.
            index:,
            text: nil,
            # Always `text`.
            type: :text
          )
          end

          sig do
            override.returns(
              {
                index: Integer,
                type: Symbol,
                text: OpenAI::Beta::Threads::TextDelta
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
