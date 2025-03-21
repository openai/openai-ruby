# typed: strong

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::BaseModel
        sig { returns(String) }
        attr_accessor :text

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
