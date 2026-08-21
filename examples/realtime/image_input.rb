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
        JPEG_FRAME_MARKERS = [
          0xC0,
          0xC1,
          0xC2,
          0xC3,
          0xC5,
          0xC6,
          0xC7,
          0xC9,
          0xCA,
          0xCB,
          0xCD,
          0xCE,
          0xCF
        ].freeze
        JPEG_LOSSLESS_FRAME_MARKERS = [0xC3, 0xC7, 0xCB, 0xCF].freeze
        JPEG_PROGRESSIVE_FRAME_MARKERS = [0xC2, 0xC6, 0xCA, 0xCE].freeze

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

          row_sizes = passes.map { |pass_width, _| ((pass_width * bits_per_pixel) + 7) / 8 }
          expected_size = passes.each_with_index.sum do |(_, pass_height), index|
            pass_height * (row_sizes.fetch(index) + 1)
          end

          valid_png_scanlines?(idat, passes, row_sizes, expected_size)
        end

        def valid_png_scanlines?(idat, passes, row_sizes, expected_size, inflater: Zlib::Inflate.new)
          output_size = 0
          pass_index = 0
          rows_remaining = passes.fetch(pass_index).fetch(1)
          scanline_size = row_sizes.fetch(pass_index) + 1
          scanline_offset = 0

          inflater.inflate(idat) do |chunk|
            return false if chunk.bytesize > expected_size - output_size

            output_size += chunk.bytesize
            chunk.each_byte do |byte|
              return false if scanline_offset.zero? && !(0..4).cover?(byte)

              scanline_offset += 1
              next unless scanline_offset == scanline_size

              scanline_offset = 0
              rows_remaining -= 1
              next unless rows_remaining.zero?

              pass_index += 1
              next if pass_index == passes.length

              rows_remaining = passes.fetch(pass_index).fetch(1)
              scanline_size = row_sizes.fetch(pass_index) + 1
            end
          end

          inflater.finished? &&
            inflater.total_in == idat.bytesize &&
            output_size == expected_size &&
            pass_index == passes.length
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
          frame = nil
          saw_scan = false
          while offset < bytes.bytesize
            return false unless bytes.getbyte(offset) == 0xFF

            offset += 1
            offset += 1 while bytes.getbyte(offset) == 0xFF
            marker = bytes.getbyte(offset)
            return false unless marker

            offset += 1
            if marker == 0xD9
              return !frame.nil? && frame.fetch(:height).positive? && saw_scan && offset == bytes.bytesize
            end

            next if marker == 0x01 || (0xD0..0xD7).cover?(marker)
            return false if offset + 2 > bytes.bytesize

            length = bytes.byteslice(offset, 2).unpack1("n")
            return false if length < 2 || offset + length > bytes.bytesize

            data = bytes.byteslice(offset + 2, length - 2)
            if JPEG_FRAME_MARKERS.include?(marker)
              frame = jpeg_frame(marker, data)
              return false unless frame

              offset += length
            elsif marker == 0xDC
              return false unless saw_scan

              frame = jpeg_frame_with_dnl(frame, data)
              return false unless frame

              offset += length
            elsif marker == 0xDA
              return false unless frame
              return false unless valid_jpeg_scan_header?(data, frame)

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

        def jpeg_frame(marker, data)
          return unless data.bytesize >= 6

          precision, height, width, component_count = data.unpack("CnnC")
          return unless valid_jpeg_precision?(marker, precision)
          return unless width.positive? && component_count.positive?
          return unless data.bytesize == 6 + (3 * component_count)

          component_data = data.byteslice(6..).unpack("C*").each_slice(3).to_a
          valid_components = component_data.all? do |_, sampling, table|
            horizontal_sampling = sampling >> 4
            vertical_sampling = sampling & 0x0F
            (1..4).cover?(horizontal_sampling) &&
              (1..4).cover?(vertical_sampling) &&
              (0..3).cover?(table)
          end

          return unless valid_components

          components = component_data.to_h do |component, sampling, _|
            [component, (sampling >> 4) * (sampling & 0x0F)]
          end

          return unless components.length == component_data.length

          {marker: marker, precision: precision, height: height, components: components}
        end

        def jpeg_frame_with_dnl(frame, data)
          return unless frame && frame.fetch(:height).zero? && data.bytesize == 2

          height = data.unpack1("n")
          return unless height.positive?

          frame.merge(height: height)
        end

        def valid_jpeg_precision?(marker, precision)
          return precision == 8 if marker == 0xC0
          return (2..16).cover?(precision) if JPEG_LOSSLESS_FRAME_MARKERS.include?(marker)

          [8, 12].include?(precision)
        end

        def valid_jpeg_scan_header?(data, frame)
          return false if data.empty?

          frame_components = frame.fetch(:components)
          component_count = data.getbyte(0)
          return false unless (1..4).cover?(component_count)
          return false if component_count > frame_components.length
          return false unless data.bytesize == 4 + (2 * component_count)

          scan_components = component_count.times.map do |index|
            component = data.getbyte(1 + (2 * index))
            tables = data.getbyte(2 + (2 * index))
            return false unless frame_components.include?(component)
            return false unless (0..3).cover?(tables >> 4) && (0..3).cover?(tables & 0x0F)

            component
          end

          return false unless scan_components.uniq.length == scan_components.length
          if component_count > 1
            sampling_blocks = scan_components.sum { |component| frame_components.fetch(component) }
            return false if sampling_blocks > 10
          end

          spectral_start, spectral_end, approximation = data.byteslice(-3, 3).unpack("C3")
          valid_jpeg_scan_parameters?(
            frame,
            component_count,
            spectral_start,
            spectral_end,
            approximation
          )
        end

        def valid_jpeg_scan_parameters?(
          frame,
          component_count,
          spectral_start,
          spectral_end,
          approximation
        )
          successive_high = approximation >> 4
          successive_low = approximation & 0x0F
          frame_marker = frame.fetch(:marker)

          if JPEG_LOSSLESS_FRAME_MARKERS.include?(frame_marker)
            return (1..7).cover?(spectral_start) &&
              spectral_end.zero? &&
              successive_high.zero? &&
              successive_low < frame.fetch(:precision)
          end

          unless JPEG_PROGRESSIVE_FRAME_MARKERS.include?(frame_marker)
            return spectral_start.zero? && spectral_end == 63 && approximation.zero?
          end

          spectral_start <= spectral_end &&
            spectral_end <= 63 &&
            (!spectral_start.zero? || spectral_end.zero?) &&
            (spectral_start.zero? || component_count == 1) &&
            successive_high <= 13 &&
            successive_low <= 13 &&
            (successive_high.zero? || successive_high == successive_low + 1)
        end

        def scan_to_next_jpeg_marker(bytes, offset)
          saw_data = false
          while offset < bytes.bytesize
            if bytes.getbyte(offset) == 0xFF
              following = bytes.getbyte(offset + 1)
              return nil unless following
              if following == 0x00
                saw_data = true
              elsif !(0xD0..0xD7).cover?(following)
                return saw_data ? offset : nil
              end

              offset += 2
            else
              saw_data = true
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
