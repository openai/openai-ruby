# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class ResponseTextDeltaEvent < OpenAI::Models::Responses::ResponseTextDeltaEvent
        sig { returns(String) }
        def snapshot
        end
      end

      class ResponseTextDoneEvent < OpenAI::Models::Responses::ResponseTextDoneEvent
        sig { returns(T.untyped) }
        def parsed
        end
      end

      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
        sig { returns(String) }
        def snapshot
        end
      end

      class ResponseCompletedEvent < OpenAI::Models::Responses::ResponseCompletedEvent
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end
      end

      class ChatChunkEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(T.untyped) }
        def chunk
        end

        sig { returns(T.untyped) }
        def snapshot
        end
      end

      class ChatContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def delta
        end

        sig { returns(String) }
        def snapshot
        end

        sig { returns(T.untyped) }
        def parsed
        end
      end

      class ChatContentDoneEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def content
        end

        sig { returns(T.untyped) }
        def parsed
        end
      end

      class ChatRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def delta
        end

        sig { returns(String) }
        def snapshot
        end
      end

      class ChatRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def refusal
        end
      end

      class ChatFunctionToolCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def name
        end

        sig { returns(Integer) }
        def index
        end

        sig { returns(String) }
        def arguments_delta
        end

        sig { returns(String) }
        def arguments
        end

        sig { returns(T.untyped) }
        def parsed_arguments
        end
      end

      class ChatFunctionToolCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(String) }
        def name
        end

        sig { returns(Integer) }
        def index
        end

        sig { returns(String) }
        def arguments
        end

        sig { returns(T.untyped) }
        def parsed_arguments
        end
      end

      class ChatLogprobsContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(T.untyped) }
        def content
        end
      end

      class ChatLogprobsContentDoneEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(T.untyped) }
        def content
        end
      end

      class ChatLogprobsRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(T.untyped) }
        def refusal
        end
      end

      class ChatLogprobsRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        sig { returns(T.untyped) }
        def refusal
        end
      end

      class ChatCompletionStream
        sig { returns(T.untyped) }
        def each
        end
      end
    end
  end
end
