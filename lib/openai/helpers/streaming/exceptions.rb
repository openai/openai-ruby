# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      class StreamError < StandardError; end

      class LengthFinishReasonError < StreamError
        attr_reader :completion

        def initialize(completion:)
          @completion = completion
          super("Stream finished due to length limit")
        end
      end

      class ContentFilterFinishReasonError < StreamError
        def initialize
          super("Stream finished due to content filter")
        end
      end
    end
  end
end

module OpenAI
  LengthFinishReasonError = Helpers::Streaming::LengthFinishReasonError
  ContentFilterFinishReasonError = Helpers::Streaming::ContentFilterFinishReasonError
end
