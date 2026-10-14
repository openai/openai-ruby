#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module ImageInput
        module_function

        # The application owns image fetching, decoding, and content validation.
        # This example only demonstrates the Realtime image-input lifecycle.
        def run(client:, model:, image_url:, prompt:, output: $stdout)
          require_image_data_uri(image_url)

          text = client.realtime.connect(model: model) do |connection|
            connection.session.update(type: :realtime, output_modalities: [:text])
            connection.conversation.items.create(
              type: :message,
              role: :user,
              content: [
                {type: :input_image, image_url: image_url},
                {type: :input_text, text: prompt}
              ]
            )
            connection.response.create
            wait_for_text(connection)
          end

          output.puts("[realtime] image response.done status=completed")
          text
        end

        def run_with_timeout(client:, model:, image_url:, prompt:, timeout_seconds:, output: $stdout)
          result = Timeout.timeout(timeout_seconds) do
            run(
              client: client,
              model: model,
              image_url: image_url,
              prompt: prompt,
              output: output
            )
          end

          output.puts("[realtime] image input smoke test passed")
          result
        rescue OpenAI::Errors::RealtimeProtocolError
          raise RuntimeError, "Realtime protocol error.", cause: nil
        end

        def require_image_data_uri(image_url)
          prefix, payload = image_url.split(",", 2) if image_url.is_a?(String)
          supported_prefix = ["data:image/png;base64", "data:image/jpeg;base64"].include?(prefix)
          return if supported_prefix && payload && !payload.empty?

          raise(
            ArgumentError,
            "Realtime image input must be a caller-validated PNG or JPEG base64 data URI"
          )
        end

        def wait_for_text(connection)
          connection.each do |event|
            case event
            when OpenAI::Realtime::ResponseDoneEvent
              raise "Realtime response did not complete." unless event.response.status == :completed

              text = completed_text(event.response)
              raise "Realtime image response completed without text output." if text.strip.empty?

              return text
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          raise "Realtime connection closed before response.done."
        end

        def completed_text(response)
          Array(response.output)
            .filter_map do |item|
              next unless item.is_a?(OpenAI::Realtime::RealtimeConversationItemAssistantMessage)

              item.content.filter_map { |content| content.text if content.type == :output_text }.join
            end
            .join
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  OpenAI::Examples::Realtime::ImageInput.run_with_timeout(
    client: OpenAI::Client.new,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    image_url: ENV.fetch("OPENAI_REALTIME_IMAGE_URL"),
    prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Describe this image concisely."),
    timeout_seconds: Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))
  )
end
