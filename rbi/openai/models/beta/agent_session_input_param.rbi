# typed: strong

module OpenAI
  module Models

    module Beta

      # Input submitted to an existing session.
      module AgentSessionInputParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage,
            OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel,
            OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult
          )
        end

        class AgentSessionInputMessage < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage,
              OpenAI::Internal::AnyHash
            )
          end

          # The user messages to add to the session.
          sig { returns(T::Array[OpenAI::Beta::AgentSessionInputMessageParam]) }
          attr_accessor :input

          # The type of the object. Always `agent.session.input.message`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Adds one or more user messages and starts a turn.
          sig do
            params(

              input: T::Array[OpenAI::Beta::AgentSessionInputMessageParam::OrHash],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The user messages to add to the session.
            input:,

            # The type of the object. Always `agent.session.input.message`.

            type: :"agent.session.input.message"
          )
          end

          sig do
            override.returns(
              {input: T::Array[OpenAI::Beta::AgentSessionInputMessageParam], type: Symbol}
            )
          end
          def to_hash
          end

        end

        class AgentSessionInputCancel < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `agent.session.input.cancel`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Cancels the session's active turn.
          sig do
            params(

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The type of the object. Always `agent.session.input.cancel`.

            type: :"agent.session.input.cancel"
          )
          end

          sig do
            override.returns(
              {type: Symbol}
            )
          end
          def to_hash
          end

        end

        class AgentSessionInputToolResult < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the function call.
          sig { returns(String) }
          attr_accessor :call_id

          # Whether the function call succeeded.
          sig { returns(T::Boolean) }
          attr_accessor :success

          # The ID of the turn that requested the function call.
          sig { returns(String) }
          attr_accessor :turn_id

          # The type of the object. Always `agent.session.input.tool_result`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The error message when the call failed.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # A function result represented as text or supported model-input content.
          sig {
            returns(
              T.nilable(
                T.any(
                  String,
                  T::Array[
                    T.any(OpenAI::Beta::InputContentParam::InputText, OpenAI::Beta::InputContentParam::InputImage)
                  ]
                )
              )
            )
          }
          attr_accessor :output

          # Submits the result of a function call.
          sig do
            params(

              call_id: String,

              success: T::Boolean,

              turn_id: String,

              error: T.nilable(String),

              output: T.nilable(
                T.any(
                  String,
                  T::Array[
                    T.any(
                      OpenAI::Beta::InputContentParam::InputText::OrHash,
                      OpenAI::Beta::InputContentParam::InputImage::OrHash
                    )
                  ]
                )
              ),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the function call.
            call_id:,

            # Whether the function call succeeded.
            success:,

            # The ID of the turn that requested the function call.
            turn_id:,

            # The error message when the call failed.
            error: nil,

            # A function result represented as text or supported model-input content.
            output: nil,

            # The type of the object. Always `agent.session.input.tool_result`.

            type: :"agent.session.input.tool_result"
          )
          end

          sig do
            override.returns(
              {
                call_id: String,
                success: T::Boolean,
                turn_id: String,
                type: Symbol,
                error: T.nilable(String),
                output: T.nilable(
                  T.any(
                    String,
                    T::Array[
                      T.any(OpenAI::Beta::InputContentParam::InputText, OpenAI::Beta::InputContentParam::InputImage)
                    ]
                  )
                )
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentSessionInputParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
