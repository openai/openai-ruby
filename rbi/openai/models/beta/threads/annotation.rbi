# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # A citation within the message that points to a specific quote from a specific
        # File associated with the assistant or the message. Generated when the assistant
        # uses the "file_search" tool to search files.
        module Annotation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::FileCitationAnnotation,
                OpenAI::Beta::Threads::FilePathAnnotation
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::Threads::Annotation::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
