# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # A citation within the message that points to a specific quote from a specific
        #   File associated with the assistant or the message. Generated when the assistant
        #   uses the "file_search" tool to search files.
        class AnnotationDelta < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation]
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
