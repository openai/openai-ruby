# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputAudio < OpenAI::BaseModel
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
        sig { params(data: String, transcript: String, type: Symbol).returns(T.attached_class) }
        def self.new(data:, transcript:, type: :output_audio)
        end

        sig { override.returns({data: String, transcript: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
