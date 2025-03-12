# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageContent < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::ImageFileContentBlock], [Symbol, OpenAI::Models::Beta::Threads::ImageURLContentBlock], [Symbol, OpenAI::Models::Beta::Threads::TextContentBlock], [Symbol, OpenAI::Models::Beta::Threads::RefusalContentBlock]]
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
