# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Annotation < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::FileCitationAnnotation], [Symbol, OpenAI::Models::Beta::Threads::FilePathAnnotation]]
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
