# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      # Creates or resumes a streaming response and parses structured outputs.
      # @overload stream(access_programs: nil, **params)
      #   @param access_programs [OpenAI::Models::Responses::ResponseCreateParams::AccessPrograms]
      #     Domain-specific access programs to use for this request.
      #   @param params [Hash{Symbol=>Object}] Other response creation or retrieval parameters.
      def stream(params)
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        starting_after, response_id = parsed.values_at(:starting_after, :response_id)

        if starting_after && !response_id
          raise ArgumentError, "starting_after can only be used with response_id"
        end

        model, tool_models = get_structured_output_models(parsed)

        unwrap = -> (raw) do
          if raw[:type] == "response.completed" && raw[:response]
            parse_structured_outputs!(raw[:response], model, tool_models)
          end

          raw
        end

        if response_id
          retrieve_params = parsed.slice(:include, :starting_after)
          retrieve_params[:request_options] = options

          raw_stream = retrieve_streaming_internal(
            response_id,
            params: retrieve_params,
            unwrap: unwrap
          )
        else
          parsed[:stream] = true

          raw_stream = @client.request(
            method: :post,
            path: "responses",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Models::Responses::ResponseStreamEvent,
            unwrap: unwrap,
            security: {bearer_auth: true},
            options: options
          )
        end

        OpenAI::Streaming::ResponseStream.new(
          raw_stream: raw_stream,
          text_format: model,
          starting_after: starting_after
        )
      end

      private def retrieve_streaming_internal(response_id, params:, unwrap:)
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        parsed.store(:stream, true)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          headers: {"accept" => "text/event-stream"},
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          security: {bearer_auth: true},
          options: options,
          unwrap: unwrap
        )
      end
    end
  end
end
