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

        # A summary of the reasoning output from the model so far.
        sig { returns(String) }
        attr_accessor :text

        # The type of the object. Always `summary_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A summary text from the model.
        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # A summary of the reasoning output from the model so far.
          text:,
          # The type of the object. Always `summary_text`.
          type: :summary_text
        )
        end

        sig { override.returns({ text: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
