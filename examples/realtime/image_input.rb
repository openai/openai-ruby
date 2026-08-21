#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require "zlib"

require_relative "../../lib/openai"
require_relative "jpeg_entropy_validation"

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
        JPEG_SUPPORTED_FRAME_MARKERS = [0xC0, 0xC1, 0xC2, 0xC3].freeze
        JPEG_DC_SEEN = 1 << 64
        JPEG_MAX_DATA_UNITS = 1_000_000
        JPEG_MAX_DECODED_UNITS = 4_000_000

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
          palette = nil
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
            if type == "PLTE"
              return false if saw_idat || palette

              palette = data
            end

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

          saw_idat &&
            saw_iend &&
            offset == bytes.bytesize &&
            valid_png_data?(ihdr, idat, palette)
        end

        def valid_png_data?(ihdr, idat, palette)
          layout = png_layout(ihdr)
          return false unless layout

          width, height, bit_depth, color_type, bits_per_pixel, interlace = layout
          return false unless valid_png_palette?(palette, bit_depth, color_type)

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

          [
            width,
            height,
            bit_depth,
            color_type,
            PNG_CHANNELS.fetch(color_type) * bit_depth,
            interlace
          ]
        end

        def valid_png_palette?(palette, bit_depth, color_type)
          return palette.nil? if [0, 4].include?(color_type)
          return color_type != 3 if palette.nil?
          return false unless palette.bytesize.between?(3, 768) && (palette.bytesize % 3).zero?

          color_type != 3 || (palette.bytesize / 3) <= (1 << bit_depth)
        end

        def png_pass_size(full_size, start, step)
          return 0 if full_size <= start

          (full_size - start + step - 1) / step
        end

        def valid_jpeg?(bytes)
          return false unless bytes.start_with?(JPEG_SIGNATURE)

          offset = 2
          frame = nil
          scans = []
          quantization_tables = {}
          huffman_tables = {}
          restart_interval = 0
          while offset < bytes.bytesize
            return false unless bytes.getbyte(offset) == 0xFF

            offset += 1
            offset += 1 while bytes.getbyte(offset) == 0xFF
            marker = bytes.getbyte(offset)
            return false unless marker

            offset += 1
            if marker == 0xD9
              return false unless frame && frame.fetch(:height).positive? && offset == bytes.bytesize

              return valid_jpeg_scans?(frame, scans)
            end

            next if marker == 0x01 || (0xD0..0xD7).cover?(marker)
            return false if offset + 2 > bytes.bytesize

            length = bytes.byteslice(offset, 2).unpack1("n")
            return false if length < 2 || offset + length > bytes.bytesize

            data = bytes.byteslice(offset + 2, length - 2)
            if marker == 0xDB
              tables = jpeg_quantization_tables(data)
              return false unless tables

              quantization_tables.merge!(tables)
              offset += length
            elsif marker == 0xC4
              tables = jpeg_huffman_tables(data)
              return false unless tables

              huffman_tables.merge!(tables)
              offset += length
            elsif marker == 0xDD
              return false unless data.bytesize == 2

              restart_interval = data.unpack1("n")
              offset += length
            elsif JPEG_FRAME_MARKERS.include?(marker)
              return false unless JPEG_SUPPORTED_FRAME_MARKERS.include?(marker)
              return false if frame

              frame = jpeg_frame(marker, data)
              return false unless frame

              offset += length
            elsif marker == 0xDC
              return false if scans.empty?

              frame = jpeg_frame_with_dnl(frame, data)
              return false unless frame

              offset += length
            elsif marker == 0xDA
              return false unless frame

              scan = jpeg_scan(data, frame)
              return false unless scan
              unless valid_jpeg_scan_tables?(
                  scan,
                  frame,
                  quantization_tables,
                  huffman_tables
                )
                return false
              end

              offset += length
              scan_data = jpeg_scan_data(bytes, offset, restart_interval)
              return false unless scan_data

              offset, entropy_segments = scan_data
              scan[:entropy_segments] = entropy_segments
              scan[:huffman_tables] = huffman_tables.dup
              scan[:restart_interval] = restart_interval
              scans << scan
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
              (0..3).cover?(table) &&
              (!JPEG_LOSSLESS_FRAME_MARKERS.include?(marker) || table.zero?)
          end

          return unless valid_components

          components = component_data.to_h do |component, sampling, table|
            [
              component,
              {
                horizontal_sampling: sampling >> 4,
                vertical_sampling: sampling & 0x0F,
                quantization_table: table
              }
            ]
          end

          return unless components.length == component_data.length

          {
            marker: marker,
            precision: precision,
            width: width,
            height: height,
            components: components
          }
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

        def jpeg_scan(data, frame)
          return if data.empty?

          frame_components = frame.fetch(:components)
          component_count = data.getbyte(0)
          return unless (1..4).cover?(component_count)
          return if component_count > frame_components.length
          return unless data.bytesize == 4 + (2 * component_count)

          scan_components = []
          index = 0
          while index < component_count
            component = data.getbyte(1 + (2 * index))
            tables = data.getbyte(2 + (2 * index))
            return unless frame_components.include?(component)
            return unless (0..3).cover?(tables >> 4) && (0..3).cover?(tables & 0x0F)

            scan_components << {id: component, dc_table: tables >> 4, ac_table: tables & 0x0F}
            index += 1
          end

          component_ids = scan_components.map { _1.fetch(:id) }
          return unless component_ids.uniq.length == component_ids.length
          if component_count > 1
            sampling_blocks = component_ids.sum do |id|
              component = frame_components.fetch(id)
              component.fetch(:horizontal_sampling) * component.fetch(:vertical_sampling)
            end

            return if sampling_blocks > 10
          end

          spectral_start, spectral_end, approximation = data.byteslice(-3, 3).unpack("C3")
          unless valid_jpeg_scan_parameters?(
              frame,
              component_count,
              spectral_start,
              spectral_end,
              approximation
            )
            return
          end

          {
            components: scan_components,
            spectral_start: spectral_start,
            spectral_end: spectral_end,
            successive_high: approximation >> 4,
            successive_low: approximation & 0x0F
          }
        end

        def valid_jpeg_scan_tables?(
          scan,
          frame,
          quantization_tables,
          huffman_tables
        )
          lossless = JPEG_LOSSLESS_FRAME_MARKERS.include?(frame.fetch(:marker))
          unless lossless
            unless scan.fetch(:components).all? do |component|
                frame_component = frame.fetch(:components).fetch(component.fetch(:id))
                precision = quantization_tables[frame_component.fetch(:quantization_table)]
                !precision.nil? && (frame.fetch(:marker) != 0xC0 || precision.zero?)
              end

              return false
            end
          end

          scan.fetch(:components).all? do |component|
            valid_jpeg_component_tables?(component, scan, frame, huffman_tables)
          end
        end

        def valid_jpeg_component_tables?(component, scan, frame, coding_tables)
          if JPEG_LOSSLESS_FRAME_MARKERS.include?(frame.fetch(:marker))
            table = coding_tables[[0, component.fetch(:dc_table)]]
            return component.fetch(:ac_table).zero? &&
              valid_jpeg_huffman_symbols?(table, frame, table_class: 0)
          end

          if JPEG_PROGRESSIVE_FRAME_MARKERS.include?(frame.fetch(:marker))
            if scan.fetch(:spectral_start).zero?
              return component.fetch(:ac_table).zero? if scan.fetch(:successive_high).positive?

              table = coding_tables[[0, component.fetch(:dc_table)]]
              return component.fetch(:ac_table).zero? &&
                valid_jpeg_huffman_symbols?(table, frame, table_class: 0)
            end

            table = coding_tables[[1, component.fetch(:ac_table)]]
            return component.fetch(:dc_table).zero? &&
              valid_jpeg_huffman_symbols?(table, frame, table_class: 1)
          end

          dc_table = coding_tables[[0, component.fetch(:dc_table)]]
          ac_table = coding_tables[[1, component.fetch(:ac_table)]]
          valid_jpeg_huffman_symbols?(dc_table, frame, table_class: 0) &&
            valid_jpeg_huffman_symbols?(ac_table, frame, table_class: 1)
        end

        def jpeg_quantization_tables(data)
          tables = {}
          offset = 0
          while offset < data.bytesize
            definition = data.getbyte(offset)
            return unless definition

            precision = definition >> 4
            table_id = definition & 0x0F
            return unless [0, 1].include?(precision) && (0..3).cover?(table_id)

            value_bytes = 64 * (precision + 1)
            values = data.byteslice(offset + 1, value_bytes)
            return unless values&.bytesize == value_bytes

            quantizers = precision.zero? ? values.unpack("C*") : values.unpack("n*")
            return unless quantizers.all?(&:positive?)

            tables[table_id] = precision
            offset += 1 + value_bytes
          end

          tables unless tables.empty?
        end

        def jpeg_huffman_tables(data)
          tables = {}
          offset = 0
          while offset < data.bytesize
            definition = data.getbyte(offset)
            code_counts = data.byteslice(offset + 1, 16)&.unpack("C*")
            return unless definition && code_counts&.length == 16

            table_class = definition >> 4
            table_id = definition & 0x0F
            return unless [0, 1].include?(table_class) && (0..3).cover?(table_id)

            symbol_count = code_counts.sum
            symbols = data.byteslice(offset + 17, symbol_count)&.unpack("C*")
            return unless symbols&.length == symbol_count

            table = jpeg_huffman_table(code_counts, symbols)
            return unless table

            tables[[table_class, table_id]] = table
            offset += 17 + symbol_count
          end

          tables unless tables.empty?
        end

        def jpeg_huffman_table(code_counts, symbols)
          return if symbols.empty?

          codes = {}
          code = 0
          symbol_index = 0
          bit_index = 0
          while bit_index < code_counts.length
            count = code_counts.fetch(bit_index)
            bit_length = bit_index + 1
            count_index = 0
            while count_index < count
              return if code >= (1 << bit_length) - 1

              codes[[bit_length, code]] = symbols.fetch(symbol_index)
              code += 1
              symbol_index += 1
              count_index += 1
            end

            code <<= 1
            bit_index += 1
          end

          {codes: codes, max_bit_length: code_counts.rindex(&:positive?).to_i + 1, symbols: symbols}
        end

        def valid_jpeg_huffman_symbols?(table, frame, table_class:)
          return false unless table

          precision = frame.fetch(:precision)
          if table_class.zero?
            maximum_category = JPEG_LOSSLESS_FRAME_MARKERS.include?(frame.fetch(:marker)) ? 16 : precision + 3
            return table.fetch(:symbols).all? { _1 <= maximum_category }
          end

          maximum_category = precision + 2
          table.fetch(:symbols).all? do |symbol|
            run_length = symbol >> 4
            category = symbol & 0x0F
            valid_zero_run = if JPEG_PROGRESSIVE_FRAME_MARKERS.include?(frame.fetch(:marker))
              category.zero?
            else
              category.zero? && [0, 15].include?(run_length)
            end

            valid_zero_run ||
              category.between?(1, maximum_category)
          end
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

        def jpeg_scan_data(bytes, offset, restart_interval)
          segments = [+"".b]
          restart_index = 0
          while offset < bytes.bytesize
            if bytes.getbyte(offset) == 0xFF
              following = bytes.getbyte(offset + 1)
              return unless following

              if following == 0x00
                segments.fetch(-1) << 0xFF
              elsif (0xD0..0xD7).cover?(following)
                return unless restart_interval.positive?
                return unless following == 0xD0 + (restart_index % 8)

                segments << +"".b
                restart_index += 1
              else
                return [offset, segments]
              end

              offset += 2
            else
              segments.fetch(-1) << bytes.getbyte(offset)
              offset += 1
            end
          end

          nil
        end

        def valid_jpeg_scans?(frame, scans)
          JPEGEntropyValidation.valid?(frame, scans)
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
