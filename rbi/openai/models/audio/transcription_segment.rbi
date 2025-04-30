# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionSegment < OpenAI::Internal::Type::BaseModel
        # Unique identifier of the segment.
        sig { returns(Integer) }
        attr_accessor :id

        # Average logprob of the segment. If the value is lower than -1, consider the
        # logprobs failed.
        sig { returns(Float) }
        attr_accessor :avg_logprob

        # Compression ratio of the segment. If the value is greater than 2.4, consider the
        # compression failed.
        sig { returns(Float) }
        attr_accessor :compression_ratio

        # End time of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :end_

        # Probability of no speech in the segment. If the value is higher than 1.0 and the
        # `avg_logprob` is below -1, consider this segment silent.
        sig { returns(Float) }
        attr_accessor :no_speech_prob

        # Seek offset of the segment.
        sig { returns(Integer) }
        attr_accessor :seek

        # Start time of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :start

        # Temperature parameter used for generating the segment.
        sig { returns(Float) }
        attr_accessor :temperature

        # Text content of the segment.
        sig { returns(String) }
        attr_accessor :text

        # Array of token IDs for the text content.
        sig { returns(T::Array[Integer]) }
        attr_accessor :tokens

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
        def self.new(
          # Unique identifier of the segment.
          id:,
          # Average logprob of the segment. If the value is lower than -1, consider the
          # logprobs failed.
          avg_logprob:,
          # Compression ratio of the segment. If the value is greater than 2.4, consider the
          # compression failed.
          compression_ratio:,
          # End time of the segment in seconds.
          end_:,
          # Probability of no speech in the segment. If the value is higher than 1.0 and the
          # `avg_logprob` is below -1, consider this segment silent.
          no_speech_prob:,
          # Seek offset of the segment.
          seek:,
          # Start time of the segment in seconds.
          start:,
          # Temperature parameter used for generating the segment.
          temperature:,
          # Text content of the segment.
          text:,
          # Array of token IDs for the text content.
          tokens:
        ); end
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
        def to_hash; end
      end
    end
  end
end
