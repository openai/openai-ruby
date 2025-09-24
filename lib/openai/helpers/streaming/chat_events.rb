# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      # Raw streaming chunk event with accumulated completion snapshot.
      #
      # This is the fundamental event that wraps each raw chunk from the API
      # along with the accumulated state up to that point. All other events
      # are derived from processing these chunks.
      #
      # @example
      #   event.chunk     # => ChatCompletionChunk (raw API response)
      #   event.snapshot  # => ParsedChatCompletion (accumulated state)
      class ChatChunkEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :chunk
        required :chunk, -> { OpenAI::Chat::ChatCompletionChunk }
        required :snapshot, -> { OpenAI::Chat::ParsedChatCompletion }
      end

      # Incremental text content update event.
      #
      # Emitted as the assistant's text response is being generated. Each event
      # contains the new text fragment (delta) and the complete accumulated
      # text so far (snapshot).
      #
      # @example
      #   event.delta    # => "Hello"        (new fragment)
      #   event.snapshot # => "Hello world"  (accumulated text)
      #   event.parsed   # => {name: "John"} (if using structured outputs)
      class ChatContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"content.delta"
        required :delta, String
        required :snapshot, String
        optional :parsed, Object # Partially parsed structured output
      end

      # Text content completion event.
      #
      # Emitted when the assistant has finished generating text content.
      # Contains the complete text and, if applicable, the fully parsed
      # structured output.
      #
      # @example
      #   event.content # => "Hello world! How can I help?"
      #   event.parsed  # => {name: "John", age: 30} (if using structured outputs)
      class ChatContentDoneEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"content.done"
        required :content, String
        optional :parsed, Object # Fully parsed structured output
      end

      # Incremental refusal update event.
      #
      # Emitted when the assistant is refusing to fulfill a request.
      # Contains the new refusal text fragment and accumulated refusal message.
      #
      # @example
      #   event.delta    # => "I cannot"
      #   event.snapshot # => "I cannot help with that request"
      class ChatRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"refusal.delta"
        required :delta, String
        required :snapshot, String
      end

      # Refusal completion event.
      #
      # Emitted when the assistant has finished generating a refusal message.
      # Contains the complete refusal text.
      #
      # @example
      #   event.refusal # => "I cannot help with that request as it violates..."
      class ChatRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"refusal.done"
        required :refusal, String
      end

      # Incremental function tool call arguments update.
      #
      # Emitted as function arguments are being streamed. Provides both the
      # raw JSON fragments and incrementally parsed arguments for strict tools.
      #
      # @example
      #   event.name            # => "get_weather"
      #   event.index           # => 0 (tool call index in array)
      #   event.arguments_delta # => '{"location": "San'  (new fragment)
      #   event.arguments       # => '{"location": "San Francisco"'  (accumulated JSON)
      #   event.parsed # => {location: "San Francisco"}  (if strict: true)
      class ChatFunctionToolCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"tool_calls.function.arguments.delta"
        required :name, String
        required :index, Integer
        required :arguments_delta, String
        required :arguments, String
        required :parsed, Object
      end

      # Function tool call arguments completion event.
      #
      # Emitted when a function tool call's arguments are complete.
      # For tools defined with `strict: true`, the arguments will be fully
      # parsed and validated. For non-strict tools, only raw JSON is available.
      #
      # @example With strict tool
      #   event.name             # => "get_weather"
      #   event.arguments        # => '{"location": "San Francisco", "unit": "celsius"}'
      #   event.parsed # => {location: "San Francisco", unit: "celsius"}
      #
      # @example Without strict tool
      #   event.parsed # => nil (parse JSON from event.arguments manually)
      class ChatFunctionToolCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"tool_calls.function.arguments.done"
        required :name, String
        required :index, Integer
        required :arguments, String
        required :parsed, Object # (only for strict: true tools)
      end

      # Incremental logprobs update for content tokens.
      #
      # Emitted when logprobs are requested and content tokens are being generated.
      # Contains log probability information for the new tokens and accumulated
      # logprobs for all content tokens so far.
      #
      # @example
      #   event.content[0].token        # => "Hello"
      #   event.content[0].logprob      # => -0.31725305
      #   event.content[0].top_logprobs # => [{token: "Hello", logprob: -0.31725305}, ...]
      #   event.snapshot                # => [all logprobs accumulated so far]
      class ChatLogprobsContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"logprobs.content.delta"
        required :content, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
        required :snapshot, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
      end

      # Logprobs completion event for content tokens.
      #
      # Emitted when content generation is complete and logprobs were requested.
      # Contains the complete array of log probabilities for all content tokens.
      #
      # @example
      #   event.content.each do |logprob|
      #     puts "Token: #{logprob.token}, Logprob: #{logprob.logprob}"
      #   end
      class ChatLogprobsContentDoneEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"logprobs.content.done"
        required :content, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
      end

      # Incremental logprobs update for refusal tokens.
      #
      # Emitted when logprobs are requested and refusal tokens are being generated.
      # Contains log probability information for refusal message tokens.
      #
      # @example
      #   event.refusal[0].token   # => "I"
      #   event.refusal[0].logprob # => -0.12345
      #   event.snapshot           # => [all refusal logprobs accumulated so far]
      class ChatLogprobsRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"logprobs.refusal.delta"
        required :refusal, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
        required :snapshot, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
      end

      # Logprobs completion event for refusal tokens.
      #
      # Emitted when refusal generation is complete and logprobs were requested.
      # Contains the complete array of log probabilities for all refusal tokens.
      #
      # @example
      #   event.refusal.each do |logprob|
      #     puts "Refusal token: #{logprob.token}, Logprob: #{logprob.logprob}"
      #   end
      class ChatLogprobsRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        required :type, const: :"logprobs.refusal.done"
        required :refusal, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] }
      end
    end
  end
end
