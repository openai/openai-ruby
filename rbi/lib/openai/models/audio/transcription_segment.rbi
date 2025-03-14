# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionSegment < OpenAI::BaseModel
        # Unique identifier of the segment.
        sig { returns(Integer) }
        def id
        end

        sig { params(_: Integer).returns(Integer) }
        def id=(_)
        end

        # Average logprob of the segment. If the value is lower than -1, consider the
        #   logprobs failed.
        sig { returns(Float) }
        def avg_logprob
        end

        sig { params(_: Float).returns(Float) }
        def avg_logprob=(_)
        end

        # Compression ratio of the segment. If the value is greater than 2.4, consider the
        #   compression failed.
        sig { returns(Float) }
        def compression_ratio
        end

        sig { params(_: Float).returns(Float) }
        def compression_ratio=(_)
        end

        # End time of the segment in seconds.
        sig { returns(Float) }
        def end_
        end

        sig { params(_: Float).returns(Float) }
        def end_=(_)
        end

        # Probability of no speech in the segment. If the value is higher than 1.0 and the
        #   `avg_logprob` is below -1, consider this segment silent.
        sig { returns(Float) }
        def no_speech_prob
        end

        sig { params(_: Float).returns(Float) }
        def no_speech_prob=(_)
        end

        # Seek offset of the segment.
        sig { returns(Integer) }
        def seek
        end

        sig { params(_: Integer).returns(Integer) }
        def seek=(_)
        end

        # Start time of the segment in seconds.
        sig { returns(Float) }
        def start
        end

        sig { params(_: Float).returns(Float) }
        def start=(_)
        end

        # Temperature parameter used for generating the segment.
        sig { returns(Float) }
        def temperature
        end

        sig { params(_: Float).returns(Float) }
        def temperature=(_)
        end

        # Text content of the segment.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # Array of token IDs for the text content.
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
