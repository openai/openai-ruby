# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.any(IO, StringIO)) }
        def file
        end

        sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
        def file=(_)
        end

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(T.nilable(String)) }
        def language
        end

        sig { params(_: String).returns(String) }
        def language=(_)
        end

        sig { returns(T.nilable(String)) }
        def prompt
        end

        sig { params(_: String).returns(String) }
        def prompt=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def response_format
        end

        sig { params(_: Symbol).returns(Symbol) }
        def response_format=(_)
        end

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: Float).returns(Float) }
        def temperature=(_)
        end

        sig { returns(T.nilable(T::Array[Symbol])) }
        def timestamp_granularities
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def timestamp_granularities=(_)
        end

        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            language: String,
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            timestamp_granularities: T::Array[Symbol],
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          file:,
          model:,
          language: nil,
          prompt: nil,
          response_format: nil,
          temperature: nil,
          timestamp_granularities: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                file: T.any(IO, StringIO),
                model: T.any(String, Symbol),
                language: String,
                prompt: String,
                response_format: Symbol,
                temperature: Float,
                timestamp_granularities: T::Array[Symbol],
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Model < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class TimestampGranularity < OpenAI::Enum
          abstract!

          WORD = :word
          SEGMENT = :segment

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
