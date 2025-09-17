# typed: strong

module OpenAI
  module Models
    module Conversations
      class SummaryTextContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::SummaryTextContent,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :text

        sig { returns(Symbol) }
        attr_accessor :type

        # A summary text from the model.
        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(text:, type: :summary_text)
        end

        sig { override.returns({ text: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
