# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageContentDelta < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::ImageFileDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::TextDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::RefusalDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock]]
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
