# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileContentResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::VectorStores::FileContentResponse,
              OpenAI::Internal::AnyHash
            )
          end

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
        def self.new(
          # The text content
          text: nil,
          # The content type (currently only `"text"`)
          type: nil
        )
        end

        sig { override.returns({ text: String, type: String }) }
        def to_hash
        end
      end
    end
  end
end
