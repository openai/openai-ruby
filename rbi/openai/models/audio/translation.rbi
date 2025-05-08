# typed: strong

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
