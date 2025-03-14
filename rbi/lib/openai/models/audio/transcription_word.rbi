# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionWord < OpenAI::BaseModel
        # End time of the word in seconds.
        sig { returns(Float) }
        def end_
        end

        sig { params(_: Float).returns(Float) }
        def end_=(_)
        end

        # Start time of the word in seconds.
        sig { returns(Float) }
        def start
        end

        sig { params(_: Float).returns(Float) }
        def start=(_)
        end

        # The text content of the word.
        sig { returns(String) }
        def word
        end

        sig { params(_: String).returns(String) }
        def word=(_)
        end

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
