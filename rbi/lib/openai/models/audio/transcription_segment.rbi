# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionSegment < OpenAI::BaseModel
        sig { returns(Integer) }
        def id
        end

        sig { params(_: Integer).returns(Integer) }
        def id=(_)
        end

        sig { returns(Float) }
        def avg_logprob
        end

        sig { params(_: Float).returns(Float) }
        def avg_logprob=(_)
        end

        sig { returns(Float) }
        def compression_ratio
        end

        sig { params(_: Float).returns(Float) }
        def compression_ratio=(_)
        end

        sig { returns(Float) }
        def end_
        end

        sig { params(_: Float).returns(Float) }
        def end_=(_)
        end

        sig { returns(Float) }
        def no_speech_prob
        end

        sig { params(_: Float).returns(Float) }
        def no_speech_prob=(_)
        end

        sig { returns(Integer) }
        def seek
        end

        sig { params(_: Integer).returns(Integer) }
        def seek=(_)
        end

        sig { returns(Float) }
        def start
        end

        sig { params(_: Float).returns(Float) }
        def start=(_)
        end

        sig { returns(Float) }
        def temperature
        end

        sig { params(_: Float).returns(Float) }
        def temperature=(_)
        end

        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { returns(T::Array[Integer]) }
        def tokens
        end

        sig { params(_: T::Array[Integer]).returns(T::Array[Integer]) }
        def tokens=(_)
        end

        sig do
          params(
            id: Integer,
            avg_logprob: Float,
            compression_ratio: Float,
            end_: Float,
            no_speech_prob: Float,
            seek: Integer,
            start: Float,
            temperature: Float,
            text: String,
            tokens: T::Array[Integer]
          )
            .returns(T.attached_class)
        end
        def self.new(id:, avg_logprob:, compression_ratio:, end_:, no_speech_prob:, seek:, start:, temperature:, text:, tokens:)
        end

        sig do
          override
            .returns(
              {
                id: Integer,
                avg_logprob: Float,
                compression_ratio: Float,
                end_: Float,
                no_speech_prob: Float,
                seek: Integer,
                start: Float,
                temperature: Float,
                text: String,
                tokens: T::Array[Integer]
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
