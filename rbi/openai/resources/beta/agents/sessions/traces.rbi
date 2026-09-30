# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Traces

            # Lists published root-turn traces as OTLP JSON, ordered by turn creation time and
            # ID. Unpublished traces are skipped. Each page returns data available when read;
            # it does not wait for late traces. Trace reads and the JSON response are limited
            # to 16 MiB per request. If the limit is exceeded, request fewer traces.
            sig {
              params(
                session_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Sessions::TraceListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Sessions::SessionTrace])
            }
            def list(
              # The ID of the session.
              session_id,
              # Return resources after this resource ID in the selected order.
              after: nil,
              # The maximum number of resources to return, between 1 and 100. Defaults to 20.
              limit: nil,
              # The order in which resources are returned. Defaults to `desc`.
              order: nil,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end

        end

      end

    end

  end
end
