# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class EventCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::EventCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :session_id

            # The input events to submit to the session.
            sig {
              returns(
                T::Array[
                  T.any(
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult
                  )
                ]
              )
            }
            attr_accessor :events

            sig { returns(T.nilable(String)) }
            attr_reader :idempotency_key

            sig { params(idempotency_key: String).void }
            attr_writer :idempotency_key

            sig do
              params(

                session_id: String,

                events: T::Array[
                  T.any(
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage::OrHash,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel::OrHash,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult::OrHash
                  )
                ],

                idempotency_key: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              session_id:,

              # The input events to submit to the session.
              events:,

              idempotency_key: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  session_id: String,
                  events: T::Array[
                    T.any(
                      OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage,
                      OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel,
                      OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult
                    )
                  ],
                  idempotency_key: String,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
