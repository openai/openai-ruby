# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class ResponseStream
        include OpenAI::Internal::Type::BaseStream

        # Define the type union for streaming events that can be yielded
        ResponseStreamEvent =
          T.type_alias do
            T.any(
              OpenAI::Streaming::ResponseTextDeltaEvent,
              OpenAI::Streaming::ResponseTextDoneEvent,
              OpenAI::Streaming::ResponseCompletedEvent,
              OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent,
              # Pass through other raw events
              OpenAI::Models::Responses::ResponseStreamEvent::Variants
            )
          end

        Message = type_member { { fixed: ResponseStreamEvent } }
        Elem = type_member { { fixed: ResponseStreamEvent } }

        sig do
          params(
            raw_stream: T.untyped,
            text_format: T.untyped,
            starting_after: T.nilable(Integer)
          ).void
        end
        def initialize(raw_stream:, text_format:, starting_after:)
        end

        sig { void }
        def close
        end

        sig { returns(T.self_type) }
        def until_done
        end

        sig { returns(OpenAI::Models::Responses::Response) }
        def get_final_response
        end

        sig { returns(String) }
        def get_output_text
        end

        sig { returns(T::Enumerator::Lazy[String]) }
        def text
        end

        # Override the each method to properly type the yielded events
        sig do
          params(
            block: T.nilable(T.proc.params(event: ResponseStreamEvent).void)
          ).returns(T.any(T.self_type, T::Enumerator[ResponseStreamEvent]))
        end
        def each(&block)
        end

        private

        sig { returns(T.untyped) }
        def iterator
        end
      end

      class ResponseStreamState
        sig { returns(T.nilable(OpenAI::Models::Responses::Response)) }
        attr_reader :completed_response

        sig { params(text_format: T.untyped).void }
        def initialize(text_format:)
        end

        sig { params(event: T.untyped).returns(T::Array[T.untyped]) }
        def handle_event(event)
        end

        sig do
          params(
            event: T.untyped,
            current_snapshot: T.nilable(OpenAI::Models::Responses::Response)
          ).returns(OpenAI::Models::Responses::Response)
        end
        def accumulate_event(event:, current_snapshot:)
        end

        private

        sig { params(text: T.nilable(String)).returns(T.untyped) }
        def parse_structured_text(text)
        end

        sig { params(object: T.untyped, expected_type: Symbol).void }
        def assert_type(object, expected_type)
        end
      end
    end
  end
end
