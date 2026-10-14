# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class StreamError < StandardError
      end

      class LengthFinishReasonError < OpenAI::Helpers::Streaming::StreamError
        sig { returns(OpenAI::Chat::ParsedChatCompletion) }
        attr_reader :completion

        sig do
          params(completion: OpenAI::Chat::ParsedChatCompletion).returns(T.attached_class)
        end
        def self.new(completion:)
        end
      end

      class ContentFilterFinishReasonError < OpenAI::Helpers::Streaming::StreamError
        sig { returns(T.attached_class) }
        def self.new
        end
      end
    end
  end

  LengthFinishReasonError = Helpers::Streaming::LengthFinishReasonError
  ContentFilterFinishReasonError = Helpers::Streaming::ContentFilterFinishReasonError
end
