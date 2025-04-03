# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionWord < OpenAI::Internal::Type::BaseModel
        # End time of the word in seconds.
        sig { returns(Float) }
        attr_accessor :end_

        # Start time of the word in seconds.
        sig { returns(Float) }
        attr_accessor :start

        # The text content of the word.
        sig { returns(String) }
        attr_accessor :word

        sig { params(end_: Float, start: Float, word: String).returns(T.attached_class) }
        def self.new(end_:, start:, word:)
        end

        sig { override.returns({end_: Float, start: Float, word: String}) }
        def to_hash
        end
      end
    end
  end
end
