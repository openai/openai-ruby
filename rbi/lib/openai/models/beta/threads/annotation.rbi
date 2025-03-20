# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # A citation within the message that points to a specific quote from a specific
        #   File associated with the assistant or the message. Generated when the assistant
        #   uses the "file_search" tool to search files.
        module Annotation
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                  OpenAI::Models::Beta::Threads::FilePathAnnotation
                )
              }
            end

          class << self
            sig do
              override
                .returns(
                  [OpenAI::Models::Beta::Threads::FileCitationAnnotation, OpenAI::Models::Beta::Threads::FilePathAnnotation]
                )
            end
            def variants
            end
          end
        end
      end
    end
  end
end
