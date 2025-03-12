# typed: strong

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::BaseModel
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { params(text: String).returns(T.attached_class) }
        def self.new(text:)
        end

        sig { override.returns({text: String}) }
        def to_hash
        end
      end
    end
  end
end
