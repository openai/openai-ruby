# typed: strong

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Audio::Translation, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :text

        sig { params(text: String).returns(T.attached_class) }
        def self.new(text:)
        end

        sig { override.returns({ text: String }) }
        def to_hash
        end
      end
    end
  end
end
