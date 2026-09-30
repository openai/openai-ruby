# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        SessionTrace = Sessions::SessionTrace

        module Sessions

          class SessionTrace < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::SessionTrace,
                OpenAI::Internal::AnyHash
              )
            end

            # The root turn ID. Use this ID as the pagination anchor.
            sig { returns(String) }
            attr_accessor :id

            # The Unix timestamp in seconds when the root turn was created.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The object type, which is always `agent.session.trace`.
            sig { returns(Symbol) }
            attr_accessor :object

            # An OTLP JSON ExportTraceServiceRequest containing resourceSpans. Only currently
            # published data is returned; later trace updates are not awaited.
            sig { returns(T::Hash[Symbol, T.anything]) }
            attr_accessor :otlp

            # The session that owns this trace.
            sig { returns(String) }
            attr_accessor :session_id

            sig do
              params(

                id: String,

                created_at: Integer,

                otlp: T::Hash[Symbol, T.anything],

                session_id: String,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The root turn ID. Use this ID as the pagination anchor.
              id:,

              # The Unix timestamp in seconds when the root turn was created.
              created_at:,

              # An OTLP JSON ExportTraceServiceRequest containing resourceSpans. Only currently
              # published data is returned; later trace updates are not awaited.
              otlp:,

              # The session that owns this trace.
              session_id:,

              # The object type, which is always `agent.session.trace`.

              object: :"agent.session.trace"
            )
            end

            sig do
              override.returns(
                {id: String, created_at: Integer, object: Symbol, otlp: T::Hash[Symbol, T.anything], session_id: String}
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
