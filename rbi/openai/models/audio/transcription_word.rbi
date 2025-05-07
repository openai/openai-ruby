# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionWord < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # End time of the word in seconds.
        sig { returns(Float) }
        attr_accessor :end_

        # Start time of the word in seconds.
        sig { returns(Float) }
        attr_accessor :start

        # The text content of the word.
        sig { returns(String) }
        attr_accessor :word

        sig do
          params(end_: Float, start: Float, word: String).returns(
            T.attached_class
          )
        end
        def self.new(
          # End time of the word in seconds.
          end_:,
          # Start time of the word in seconds.
          start:,
          # The text content of the word.
          word:
        )
        end

        sig { override.returns({ end_: Float, start: Float, word: String }) }
        def to_hash
        end
      end
    end
  end
end
