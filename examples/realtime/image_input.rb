#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"
require_relative "websocket_text"

module OpenAI
  module Examples
    module Realtime
      module ImageInput
        PNG_SIGNATURE = "\x89PNG\r\n\x1A\n".b
        JPEG_SIGNATURE = "\xFF\xD8\xFF".b

        module_function

        def data_uri(path)
          bytes = File.binread(path)
          mime_type =
            if bytes.start_with?(PNG_SIGNATURE)
              "image/png"
            elsif bytes.start_with?(JPEG_SIGNATURE)
              "image/jpeg"
            else
              raise ArgumentError, "Realtime image input must be a PNG or JPEG file"
            end

          "data:#{mime_type};base64,#{Base64.strict_encode64(bytes)}"
        end

        def run(client:, model:, image_path:, prompt:, output: $stdout)
          client.realtime.connect(model: model) do |connection|
            connection.session.update(type: :realtime, output_modalities: [:text])
            connection.conversation.items.create(
              type: :message,
              role: :user,
              content: [
                {type: :input_image, image_url: data_uri(image_path)},
                {type: :input_text, text: prompt}
              ]
            )
            connection.response.create
            WebSocketText.stream_response(connection, output: output)
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))) do
    OpenAI::Examples::Realtime::ImageInput.run(
      client: OpenAI::Client.new,
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      image_path: ENV.fetch("REALTIME_INPUT_IMAGE"),
      prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Describe this image concisely.")
    )
  end
end
