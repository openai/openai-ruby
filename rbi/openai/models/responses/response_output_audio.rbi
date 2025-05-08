# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputAudio < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Base64-encoded audio data from the model.
        sig { returns(String) }
        attr_accessor :data

        # The transcript of the audio data from the model.
        sig { returns(String) }
        attr_accessor :transcript

        # The type of the output audio. Always `output_audio`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An audio output from the model.
        sig do
          params(data: String, transcript: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Base64-encoded audio data from the model.
          data:,
          # The transcript of the audio data from the model.
          transcript:,
          # The type of the output audio. Always `output_audio`.
          type: :output_audio
        )
        end

        sig do
          override.returns({ data: String, transcript: String, type: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
