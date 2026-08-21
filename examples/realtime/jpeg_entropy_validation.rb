# frozen_string_literal: true

module OpenAI
  module Examples
    module Realtime
      module ImageInput
        module JPEGEntropyValidation
          module_function

          def valid?(frame, scans)
            return false if scans.empty?

            state = jpeg_decoder_state(frame)
            return false unless state
            return false unless scans.all? { valid_jpeg_scan_entropy?(_1, state) }

            if JPEG_PROGRESSIVE_FRAME_MARKERS.include?(frame.fetch(:marker))
              return state.fetch(:components).values.all? do |component|
                jpeg_actual_block_indices(component).all? do |index|
                  (component.fetch(:coefficient_masks).fetch(index) & JPEG_DC_SEEN).positive?
                end
              end
            end

            state.fetch(:seen_components).length == frame.fetch(:components).length
          end

          def jpeg_decoder_state(frame)
            frame_components = frame.fetch(:components)
            maximum_horizontal = frame_components.values.map { _1.fetch(:horizontal_sampling) }.max
            maximum_vertical = frame_components.values.map { _1.fetch(:vertical_sampling) }.max
            unit_size = JPEG_LOSSLESS_FRAME_MARKERS.include?(frame.fetch(:marker)) ? 1 : 8
            mcu_columns = jpeg_divide_round_up(
              frame.fetch(:width),
              unit_size * maximum_horizontal
            )
            mcu_rows = jpeg_divide_round_up(frame.fetch(:height), unit_size * maximum_vertical)
            total_units = 0
            components = {}
            component_entries = frame_components.to_a
            component_index = 0
            while component_index < component_entries.length
              id, component = component_entries.fetch(component_index)
              horizontal = component.fetch(:horizontal_sampling)
              vertical = component.fetch(:vertical_sampling)
              padded_columns = mcu_columns * horizontal
              padded_rows = mcu_rows * vertical
              unit_count = padded_columns * padded_rows
              total_units += unit_count
              return if total_units > JPEG_MAX_DATA_UNITS

              components[id] = {
                actual_columns: jpeg_divide_round_up(
                  frame.fetch(:width) * horizontal,
                  unit_size * maximum_horizontal
                ),
                actual_rows: jpeg_divide_round_up(
                  frame.fetch(:height) * vertical,
                  unit_size * maximum_vertical
                ),
                coefficient_masks: Array.new(unit_count, 0),
                horizontal_sampling: horizontal,
                padded_columns: padded_columns,
                successive_levels: Array.new(64),
                vertical_sampling: vertical
              }
              component_index += 1
            end

            {
              components: components,
              frame: frame,
              mcu_columns: mcu_columns,
              mcu_rows: mcu_rows,
              decoded_units: 0,
              seen_components: {}
            }
          end

          def valid_jpeg_scan_entropy?(scan, state)
            mcu_count = jpeg_scan_mcu_count(scan, state)
            progression_updates = jpeg_progression_updates(scan, state)
            return false if progression_updates == false

            decoded_units = jpeg_scan_data_unit_count(scan, state, mcu_count)
            return false if decoded_units > JPEG_MAX_DECODED_UNITS - state.fetch(:decoded_units)

            restart_interval = scan.fetch(:restart_interval)
            expected_segments = if restart_interval.positive?
              jpeg_divide_round_up(mcu_count, restart_interval)
            else
              1
            end

            segments = scan.fetch(:entropy_segments)
            return false unless segments.length == expected_segments

            mcu_index = 0
            segments.each do |data|
              return false if data.empty?

              reader = {bit_offset: 0, data: data}
              context = {eob_run: 0}
              segment_mcus = if restart_interval.positive?
                [restart_interval, mcu_count - mcu_index].min
              else
                mcu_count
              end

              segment_mcus.times do
                blocks = jpeg_mcu_blocks(scan, state, mcu_index)
                unless blocks.all? do |component, block_index, scan_component|
                    valid_jpeg_block?(reader, context, state, component, block_index, scan_component, scan)
                  end

                  return false
                end

                mcu_index += 1
              end

              return false unless context.fetch(:eob_run).zero? && valid_jpeg_padding?(reader)
            end

            return false unless mcu_index == mcu_count

            state[:decoded_units] += decoded_units
            Array(progression_updates).each do |component, coefficient, successive_low|
              component.fetch(:successive_levels)[coefficient] = successive_low
            end

            unless JPEG_PROGRESSIVE_FRAME_MARKERS.include?(state.fetch(:frame).fetch(:marker))
              scan.fetch(:components).each do |component|
                id = component.fetch(:id)
                return false if state.fetch(:seen_components)[id]

                state.fetch(:seen_components)[id] = true
              end
            end

            true
          end

          def jpeg_progression_updates(scan, state)
            return unless JPEG_PROGRESSIVE_FRAME_MARKERS.include?(state.fetch(:frame).fetch(:marker))

            first = scan.fetch(:spectral_start)
            last = scan.fetch(:spectral_end)
            successive_high = scan.fetch(:successive_high)
            expected_level = successive_high.zero? ? nil : successive_high
            updates = []
            scan_components = scan.fetch(:components)
            scan_component_index = 0
            while scan_component_index < scan_components.length
              scan_component = scan_components.fetch(scan_component_index)
              component = state.fetch(:components).fetch(scan_component.fetch(:id))
              levels = component.fetch(:successive_levels)
              coefficient = first
              while coefficient <= last
                return false unless levels.fetch(coefficient) == expected_level

                updates << [component, coefficient, scan.fetch(:successive_low)]
                coefficient += 1
              end

              scan_component_index += 1
            end

            updates
          end

          def jpeg_scan_data_unit_count(scan, state, mcu_count)
            return mcu_count if scan.fetch(:components).length == 1

            blocks_per_mcu = scan.fetch(:components).sum do |scan_component|
              component = state.fetch(:components).fetch(scan_component.fetch(:id))
              component.fetch(:horizontal_sampling) * component.fetch(:vertical_sampling)
            end

            mcu_count * blocks_per_mcu
          end

          def jpeg_scan_mcu_count(scan, state)
            return state.fetch(:mcu_columns) * state.fetch(:mcu_rows) if scan.fetch(:components).length > 1

            component = state.fetch(:components).fetch(scan.dig(:components, 0, :id))
            component.fetch(:actual_columns) * component.fetch(:actual_rows)
          end

          def jpeg_mcu_blocks(scan, state, mcu_index)
            scan_components = scan.fetch(:components)
            if scan_components.length == 1
              only_scan_component = scan_components.fetch(0)
              component = state.fetch(:components).fetch(only_scan_component.fetch(:id))
              column = mcu_index % component.fetch(:actual_columns)
              row = mcu_index / component.fetch(:actual_columns)
              return [[component, (row * component.fetch(:padded_columns)) + column, only_scan_component]]
            end

            mcu_column = mcu_index % state.fetch(:mcu_columns)
            mcu_row = mcu_index / state.fetch(:mcu_columns)
            scan_components.flat_map do |scan_component|
              component = state.fetch(:components).fetch(scan_component.fetch(:id))
              blocks = []
              vertical = 0
              while vertical < component.fetch(:vertical_sampling)
                horizontal = 0
                while horizontal < component.fetch(:horizontal_sampling)
                  column = (mcu_column * component.fetch(:horizontal_sampling)) + horizontal
                  row = (mcu_row * component.fetch(:vertical_sampling)) + vertical
                  index = (row * component.fetch(:padded_columns)) + column
                  blocks << [component, index, scan_component]
                  horizontal += 1
                end

                vertical += 1
              end

              blocks
            end
          end

          def valid_jpeg_block?(reader, context, state, component, index, scan_component, scan)
            frame_marker = state.fetch(:frame).fetch(:marker)
            if JPEG_LOSSLESS_FRAME_MARKERS.include?(frame_marker)
              return valid_lossless_jpeg_unit?(reader, scan_component, scan)
            end

            unless JPEG_PROGRESSIVE_FRAME_MARKERS.include?(frame_marker)
              return valid_sequential_jpeg_block?(reader, scan_component, scan)
            end

            valid_progressive_jpeg_block?(
              reader,
              context,
              component,
              index,
              scan_component,
              scan
            )
          end

          def valid_lossless_jpeg_unit?(reader, scan_component, scan)
            table = scan.fetch(:huffman_tables).fetch([0, scan_component.fetch(:dc_table)])
            category = jpeg_huffman_symbol(reader, table)
            !category.nil? && !jpeg_read_bits(reader, category).nil?
          end

          def valid_sequential_jpeg_block?(reader, scan_component, scan)
            tables = scan.fetch(:huffman_tables)
            dc_table = tables.fetch([0, scan_component.fetch(:dc_table)])
            ac_table = tables.fetch([1, scan_component.fetch(:ac_table)])
            category = jpeg_huffman_symbol(reader, dc_table)
            return false if category.nil? || jpeg_read_bits(reader, category).nil?

            coefficient = 1
            while coefficient <= 63
              symbol = jpeg_huffman_symbol(reader, ac_table)
              return false unless symbol

              run_length = symbol >> 4
              category = symbol & 0x0F
              if category.zero?
                return true if run_length.zero?
                return false unless run_length == 15

                coefficient += 16
              else
                coefficient += run_length
                return false if coefficient > 63 || jpeg_read_bits(reader, category).nil?

                coefficient += 1
              end
            end

            coefficient == 64
          end

          def valid_progressive_jpeg_block?(
            reader,
            context,
            component,
            index,
            scan_component,
            scan
          )
            if scan.fetch(:spectral_start).zero?
              return valid_progressive_jpeg_dc?(reader, component, index, scan_component, scan)
            end

            return false unless (component.fetch(:coefficient_masks).fetch(index) & JPEG_DC_SEEN).positive?
            if scan.fetch(:successive_high).zero?
              return valid_progressive_jpeg_ac_first?(reader, context, component, index, scan_component, scan)
            end

            valid_progressive_jpeg_ac_refinement?(
              reader,
              context,
              component,
              index,
              scan_component,
              scan
            )
          end

          def valid_progressive_jpeg_dc?(reader, component, index, scan_component, scan)
            masks = component.fetch(:coefficient_masks)
            if scan.fetch(:successive_high).positive?
              return false unless (masks.fetch(index) & JPEG_DC_SEEN).positive?

              return !jpeg_read_bits(reader, 1).nil?
            end

            return false if (masks.fetch(index) & JPEG_DC_SEEN).positive?

            table = scan.fetch(:huffman_tables).fetch([0, scan_component.fetch(:dc_table)])
            category = jpeg_huffman_symbol(reader, table)
            return false if category.nil? || jpeg_read_bits(reader, category).nil?

            masks[index] |= JPEG_DC_SEEN
            true
          end

          def valid_progressive_jpeg_ac_first?(reader, context, component, index, scan_component, scan)
            if context.fetch(:eob_run).positive?
              context[:eob_run] -= 1
              return true
            end

            table = scan.fetch(:huffman_tables).fetch([1, scan_component.fetch(:ac_table)])
            coefficient = scan.fetch(:spectral_start)
            masks = component.fetch(:coefficient_masks)
            while coefficient <= scan.fetch(:spectral_end)
              symbol = jpeg_huffman_symbol(reader, table)
              return false unless symbol

              run_length = symbol >> 4
              category = symbol & 0x0F
              if category.zero?
                if run_length == 15
                  coefficient += 16
                  next
                end

                extra = jpeg_read_bits(reader, run_length)
                return false if extra.nil?

                context[:eob_run] = (1 << run_length) + extra - 1
                return true
              end

              coefficient += run_length
              return false if coefficient > scan.fetch(:spectral_end)
              return false if jpeg_read_bits(reader, category).nil?

              masks[index] |= 1 << coefficient
              coefficient += 1
            end

            coefficient == scan.fetch(:spectral_end) + 1
          end

          def valid_progressive_jpeg_ac_refinement?(
            reader,
            context,
            component,
            index,
            scan_component,
            scan
          )
            masks = component.fetch(:coefficient_masks)
            mask = masks.fetch(index)
            if context.fetch(:eob_run).positive?
              unless refine_jpeg_coefficients?(reader, mask, scan.fetch(:spectral_start), scan.fetch(:spectral_end))
                return false
              end

              context[:eob_run] -= 1
              return true
            end

            table = scan.fetch(:huffman_tables).fetch([1, scan_component.fetch(:ac_table)])
            coefficient = scan.fetch(:spectral_start)
            while coefficient <= scan.fetch(:spectral_end)
              symbol = jpeg_huffman_symbol(reader, table)
              return false unless symbol

              run_length = symbol >> 4
              category = symbol & 0x0F
              return false unless [0, 1].include?(category)
              if category.zero? && run_length < 15
                extra = jpeg_read_bits(reader, run_length)
                return false if extra.nil?

                context[:eob_run] = (1 << run_length) + extra
                return false unless refine_jpeg_coefficients?(reader, mask, coefficient, scan.fetch(:spectral_end))

                context[:eob_run] -= 1
                return true
              end

              zeros_remaining = category.zero? ? 16 : run_length
              while coefficient <= scan.fetch(:spectral_end) && zeros_remaining.positive?
                if (mask & (1 << coefficient)).positive?
                  return false if jpeg_read_bits(reader, 1).nil?
                else
                  zeros_remaining -= 1
                end

                coefficient += 1
              end

              return false if zeros_remaining.positive?
              next if category.zero?
              while coefficient <= scan.fetch(:spectral_end) && (mask & (1 << coefficient)).positive?
                return false if jpeg_read_bits(reader, 1).nil?

                coefficient += 1
              end

              return false if coefficient > scan.fetch(:spectral_end)
              return false if jpeg_read_bits(reader, 1).nil?

              mask |= 1 << coefficient
              masks[index] = mask
              coefficient += 1
            end

            true
          end

          def refine_jpeg_coefficients?(reader, mask, first, last)
            coefficient = first
            while coefficient <= last
              if (mask & (1 << coefficient)).positive? && jpeg_read_bits(reader, 1).nil?
                return false
              end

              coefficient += 1
            end

            true
          end

          def jpeg_huffman_symbol(reader, table)
            code = 0
            bit_length = 1
            while bit_length <= table.fetch(:max_bit_length)
              bit = jpeg_read_bits(reader, 1)
              return if bit.nil?

              code = (code << 1) | bit
              symbol = table.fetch(:codes)[[bit_length, code]]
              return symbol if symbol

              bit_length += 1
            end

            nil
          end

          def jpeg_read_bits(reader, count)
            return 0 if count.zero?

            bit_offset = reader.fetch(:bit_offset)
            return if bit_offset + count > reader.fetch(:data).bytesize * 8

            value = 0
            count.times do
              byte = reader.fetch(:data).getbyte(bit_offset / 8)
              value = (value << 1) | ((byte >> (7 - (bit_offset % 8))) & 1)
              bit_offset += 1
            end

            reader[:bit_offset] = bit_offset
            value
          end

          def valid_jpeg_padding?(reader)
            remaining = (reader.fetch(:data).bytesize * 8) - reader.fetch(:bit_offset)
            return false if remaining >= 8
            return true if remaining.zero?

            jpeg_read_bits(reader, remaining) == (1 << remaining) - 1
          end

          def jpeg_actual_block_indices(component)
            indices = []
            row = 0
            while row < component.fetch(:actual_rows)
              column = 0
              while column < component.fetch(:actual_columns)
                indices << ((row * component.fetch(:padded_columns)) + column)
                column += 1
              end

              row += 1
            end

            indices
          end

          def jpeg_divide_round_up(value, divisor)
            (value + divisor - 1) / divisor
          end

        end
      end
    end
  end
end
