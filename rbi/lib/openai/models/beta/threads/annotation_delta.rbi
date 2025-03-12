# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class AnnotationDelta < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation], [Symbol, OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation]]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
