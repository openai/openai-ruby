# typed: strong

module OpenAI
  module Models
    module Responses
      # Multi-modal input and output contents.
      module ResponseContent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputText,
              OpenAI::Responses::ResponseInputImage,
              OpenAI::Responses::ResponseInputFile,
              OpenAI::Responses::ResponseInputAudio,
              OpenAI::Responses::ResponseOutputText,
              OpenAI::Responses::ResponseOutputRefusal
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseContent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
