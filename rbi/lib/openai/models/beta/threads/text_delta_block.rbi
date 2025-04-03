# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDeltaBlock < OpenAI::Internal::Type::BaseModel
          # The index of the content part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::TextDelta)) }
          attr_reader :text

          sig { params(text: T.any(OpenAI::Models::Beta::Threads::TextDelta, OpenAI::Internal::AnyHash)).void }
          attr_writer :text

          # The text content that is part of a message.
          sig do
            params(
              index: Integer,
              text: T.any(OpenAI::Models::Beta::Threads::TextDelta, OpenAI::Internal::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, text: nil, type: :text)
          end

          sig { override.returns({index: Integer, type: Symbol, text: OpenAI::Models::Beta::Threads::TextDelta}) }
          def to_hash
          end
        end
      end
    end
  end
end
