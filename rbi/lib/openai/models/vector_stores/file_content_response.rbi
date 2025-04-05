# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileContentResponse < OpenAI::Internal::Type::BaseModel
        # The text content
        sig { returns(T.nilable(String)) }
        attr_reader :text

        sig { params(text: String).void }
        attr_writer :text

        # The content type (currently only `"text"`)
        sig { returns(T.nilable(String)) }
        attr_reader :type

        sig { params(type: String).void }
        attr_writer :type

        sig { params(text: String, type: String).returns(T.attached_class) }
        def self.new(text: nil, type: nil); end

        sig { override.returns({text: String, type: String}) }
        def to_hash; end
      end
    end
  end
end
