#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require "zlib"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module ImageInput
        PNG_SIGNATURE = "\x89PNG\r\n\x1A\n".b
        JPEG_SIGNATURE = "\xFF\xD8".b
        PNG_BIT_DEPTHS = {
          0 => [1, 2, 4, 8, 16],
          2 => [8, 16],
          3 => [1, 2, 4, 8],
          4 => [8, 16],
          6 => [8, 16]
        }.freeze
        PNG_CHANNELS = {0 => 1, 2 => 3, 3 => 1, 4 => 2, 6 => 4}.freeze
        PNG_ADAM7_PASSES = [
          [0, 0, 8, 8],
          [4, 0, 8, 8],
          [0, 4, 4, 8],
          [2, 0, 4, 4],
          [0, 2, 2, 4],
          [1, 0, 2, 2],
          [0, 1, 1, 2]
        ].freeze

        module_function

        def run(client:, model:, image_path:, prompt:, output: $stdout)
          image_url = image_data_uri(image_path)

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

        def run_with_timeout(client:, model:, image_path:, prompt:, timeout_seconds:, output: $stdout)
          result = Timeout.timeout(timeout_seconds) do
            run(
              client: client,
              model: model,
              image_path: image_path,
              prompt: prompt,
              output: output
            )
          end

          output.puts("[realtime] image input smoke test passed")
          result
        rescue OpenAI::Errors::RealtimeProtocolError
          raise RuntimeError, "Realtime protocol error.", cause: nil
        end

        def image_data_uri(path)
          bytes = begin
            File.binread(path)
          rescue SystemCallError
            raise RuntimeError, "Unable to read Realtime image input.", cause: nil
          end

          mime_type = if valid_png?(bytes)
            "image/png"
          elsif valid_jpeg?(bytes)
            "image/jpeg"
          else
            raise ArgumentError, "Realtime image input must be a valid PNG or JPEG file"
          end

          "data:#{mime_type};base64,#{[bytes].pack("m0")}"
        end

        def valid_png?(bytes)
          return false unless bytes.start_with?(PNG_SIGNATURE)

          offset = PNG_SIGNATURE.bytesize
          chunk_index = 0
          ihdr = nil
          idat = +"".b
          saw_idat = false
          saw_iend = false
          while offset < bytes.bytesize
            return false if offset + 12 > bytes.bytesize

            length = bytes.byteslice(offset, 4).unpack1("N")
            type = bytes.byteslice(offset + 4, 4)
            chunk_end = offset + 12 + length
            return false if chunk_end > bytes.bytesize
            return false if chunk_index.zero? && (type != "IHDR" || length != 13)
            return false if !chunk_index.zero? && type == "IHDR"

            data = bytes.byteslice(offset + 8, length)
            expected_crc = bytes.byteslice(offset + 8 + length, 4).unpack1("N")
            return false unless Zlib.crc32(type + data) == expected_crc

            ihdr = data if type == "IHDR"
            if type == "IDAT"
              saw_idat = true
              idat << data
            end

            if type == "IEND"
              return false unless length.zero?

              saw_iend = true
              offset = chunk_end
              break
            end

            chunk_index += 1
            offset = chunk_end
          end

          saw_idat && saw_iend && offset == bytes.bytesize && valid_png_data?(ihdr, idat)
        end

        def valid_png_data?(ihdr, idat)
          layout = png_layout(ihdr)
          return false unless layout

          width, height, bits_per_pixel, interlace = layout
          passes = if interlace.zero?
            [[width, height]]
          else
            PNG_ADAM7_PASSES.filter_map do |x_start, y_start, x_step, y_step|
              pass_width = png_pass_size(width, x_start, x_step)
              pass_height = png_pass_size(height, y_start, y_step)
              [pass_width, pass_height] unless pass_width.zero? || pass_height.zero?
            end
          end

          inflater = Zlib::Inflate.new
          decompressed = inflater.inflate(idat)
          decompressed << inflater.finish
          return false unless inflater.total_in == idat.bytesize

          row_sizes = passes.map { |pass_width, _| ((pass_width * bits_per_pixel) + 7) / 8 }
          expected_size = passes.each_with_index.sum do |(_, pass_height), index|
            pass_height * (row_sizes.fetch(index) + 1)
          end

          return false unless decompressed.bytesize == expected_size

          offset = 0
          passes.each_with_index do |(_, pass_height), index|
            pass_height.times do
              return false unless (0..4).cover?(decompressed.getbyte(offset))

              offset += row_sizes.fetch(index) + 1
            end
          end

          offset == decompressed.bytesize
        rescue Zlib::Error
          false
        ensure
          inflater&.close
        end

        def png_layout(ihdr)
          return unless ihdr&.bytesize == 13

          width, height, bit_depth, color_type, compression, filter, interlace = ihdr.unpack("NNCCCCC")
          return unless width.positive? && height.positive?
          return unless width <= 0x7FFF_FFFF && height <= 0x7FFF_FFFF
          return unless PNG_BIT_DEPTHS.fetch(color_type, []).include?(bit_depth)
          return unless compression.zero? && filter.zero? && [0, 1].include?(interlace)

          [width, height, PNG_CHANNELS.fetch(color_type) * bit_depth, interlace]
        end

        def png_pass_size(full_size, start, step)
          return 0 if full_size <= start

          (full_size - start + step - 1) / step
        end

        def valid_jpeg?(bytes)
          return false unless bytes.start_with?(JPEG_SIGNATURE)

          offset = 2
          saw_frame = false
          saw_scan = false
          while offset < bytes.bytesize
            return false unless bytes.getbyte(offset) == 0xFF

            offset += 1
            offset += 1 while bytes.getbyte(offset) == 0xFF
            marker = bytes.getbyte(offset)
            return false unless marker

            offset += 1
            return saw_frame && saw_scan && offset == bytes.bytesize if marker == 0xD9
            next if marker == 0x01 || (0xD0..0xD7).cover?(marker)
            return false if offset + 2 > bytes.bytesize

            length = bytes.byteslice(offset, 2).unpack1("n")
            return false if length < 2 || offset + length > bytes.bytesize

            saw_frame ||= (0xC0..0xC3).cover?(marker) ||
              (0xC5..0xC7).cover?(marker) ||
              (0xC9..0xCB).cover?(marker) ||
              (0xCD..0xCF).cover?(marker)
            if marker == 0xDA
              saw_scan = true
              offset += length
              offset = scan_to_next_jpeg_marker(bytes, offset)
              return false unless offset
            else
              offset += length
            end
          end

          false
        end

        def scan_to_next_jpeg_marker(bytes, offset)
          while offset < bytes.bytesize
            if bytes.getbyte(offset) == 0xFF
              following = bytes.getbyte(offset + 1)
              return nil unless following
              return offset if following != 0x00 && !(0xD0..0xD7).cover?(following)

              offset += 2
            else
              offset += 1
            end
          end

          nil
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
    image_path: ENV.fetch("OPENAI_REALTIME_IMAGE"),
    prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Describe this image concisely."),
    timeout_seconds: Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))
  )
end
