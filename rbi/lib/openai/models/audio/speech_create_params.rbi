# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def input
        end

        sig { params(_: String).returns(String) }
        def input=(_)
        end

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(Symbol) }
        def voice
        end

        sig { params(_: Symbol).returns(Symbol) }
        def voice=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def response_format
        end

        sig { params(_: Symbol).returns(Symbol) }
        def response_format=(_)
        end

        sig { returns(T.nilable(Float)) }
        def speed
        end

        sig { params(_: Float).returns(Float) }
        def speed=(_)
        end

        sig do
          params(
            input: String,
            model: T.any(String, Symbol),
            voice: Symbol,
            response_format: Symbol,
            speed: Float,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(input:, model:, voice:, response_format: nil, speed: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                input: String,
                model: T.any(String, Symbol),
                voice: Symbol,
                response_format: Symbol,
                speed: Float,
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

        class Voice < OpenAI::Enum
          abstract!

          ALLOY = :alloy
          ASH = :ash
          CORAL = :coral
          ECHO = :echo
          FABLE = :fable
          ONYX = :onyx
          NOVA = :nova
          SAGE = :sage
          SHIMMER = :shimmer

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class ResponseFormat < OpenAI::Enum
          abstract!

          MP3 = :mp3
          OPUS = :opus
          AAC = :aac
          FLAC = :flac
          WAV = :wav
          PCM = :pcm

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
