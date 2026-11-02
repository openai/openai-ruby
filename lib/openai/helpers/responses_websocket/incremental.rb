# frozen_string_literal: true

module OpenAI
  module Responses
    # Optional, caller-fed provisional output for one WebSocket lane.
    # Feed the events returned by lane.receive; use a separate instance per lane.
    # This helper never reads, closes, or writes to a connection. Tools are data.
    # Terminal events stay exact; provisional facts never manufacture a Response.
    class IncrementalResponse
      include OpenAI::WebSocket::Protocol

      STATUS_ITEMS = {
        "response.code_interpreter_call.in_progress" => ["code_interpreter_call", "in_progress"],
        "response.code_interpreter_call.interpreting" => ["code_interpreter_call", "interpreting"],
        "response.code_interpreter_call.completed" => ["code_interpreter_call", "completed"],
        "response.file_search_call.in_progress" => ["file_search_call", "in_progress"],
        "response.file_search_call.searching" => ["file_search_call", "searching"],
        "response.file_search_call.completed" => ["file_search_call", "completed"],
        "response.web_search_call.in_progress" => ["web_search_call", "in_progress"],
        "response.web_search_call.searching" => ["web_search_call", "searching"],
        "response.web_search_call.completed" => ["web_search_call", "completed"],
        "response.image_generation_call.in_progress" => ["image_generation_call", "in_progress"],
        "response.image_generation_call.generating" => ["image_generation_call", "generating"],
        "response.image_generation_call.completed" => ["image_generation_call", "completed"],
        "response.mcp_call.in_progress" => ["mcp_call", "in_progress"],
        "response.mcp_call.completed" => ["mcp_call", "completed"],
        "response.mcp_call.failed" => ["mcp_call", "failed"]
      }.freeze
      private_constant :STATUS_ITEMS

      attr_reader :phase

      def initialize
        reset
      end

      # Detached typed output: the truthful contiguous projectable prefix.
      # Sparse or incomplete records stop this prefix; detailed_snapshot retains
      # their actual indices. Full reads cost time proportional to retained data.
      # Use original deltas for per-event progress and read snapshots at boundaries.
      def output
        return unless @phase == :provisional

        result = []
        while (record = @items[result.length])
          break unless record[:full]

          result <<
            OpenAI::Internal::Type::Converter.coerce(
              OpenAI::Responses::ResponseOutputItem,
              project_item(record)
            )
        end

        result
      end

      # Detached observed facts, including sparse indices and response metadata.
      # This is not a complete Response. No absent item/part type is inferred.
      def detailed_snapshot
        return if @phase.nil? || @phase == :unavailable

        if @phase == :terminal
          data = @terminal_event.deep_to_h
          response = data[:response]
          items = response.is_a?(Hash) && response[:output].is_a?(Array) ? response[:output] : []
          records = items.map { |item| make_record(item, full: true) }
          rows = records.each_with_index.map { |record, index| detailed_item(index, record) }
          return copy(
            phase: @phase,
            stream_id: data[:stream_id],
            response_id: response.is_a?(Hash) ? response[:id] : nil,
            terminal_type: data[:type],
            response: response.is_a?(Hash) ? response.reject { |key, _| key == :output } : nil,
            output: rows,
            output_text: observed_text(records)
          )
        end

        indices = @items.keys.sort
        copy(
          phase: @phase,
          stream_id: @stream_id,
          response_id: @response && @response[:id],
          terminal_type: nil,
          response: @response,
          output: indices.map { |index| detailed_item(index, @items.fetch(index)) },
          output_text: observed_text(indices.map { |index| @items.fetch(index) })
        )
      end

      # The exact consumed completion, failure, incomplete, or error event.
      def terminal_event
        @terminal_event && copy(@terminal_event)
      end

      def reset
        @phase = nil
        @items = {}
        @ids = {}
        @command_bounds = {}
        @response = nil
        @stream_id = nil
        @terminal_event = nil
        nil
      end

      def add(event)
        return if event.is_a?(OpenAI::Responses::UnknownServerEvent)

        type = event[:type].to_s
        if %w[response.completed response.failed response.incomplete error].include?(type)
          reset
          @terminal_event = copy(event)
          @phase = :terminal
          return
        end

        return if @phase == :terminal && type != "response.created"

        if %w[response.created response.queued response.in_progress].include?(type)
          response = copy(event)[:response]
          unless response.is_a?(OpenAI::Responses::Response) &&
              (response[:output].nil? || response[:output].is_a?(Array))
            raise SessionError, "Invalid Responses WebSocket created response."
          end

          reset if type == "response.created"
          return if @phase == :unavailable

          data = response.deep_to_h
          @response = data.reject { |key, _| key == :output }
          @stream_id = copy(event[:stream_id])
          if data[:output].is_a?(Array) || type == "response.created"
            @items = {}
            @ids = {}
            @command_bounds = {}
            (data[:output] || []).each_with_index do |item, index|
              replace_item(index, item)
              break if @phase == :unavailable
            end
          end

          @phase = :provisional unless @phase == :unavailable
          return
        end

        return if @phase == :unavailable

        data = copy(event).deep_to_h
        @stream_id ||= data[:stream_id]
        if (status = STATUS_ITEMS[type])
          record = item_for(data, status.first)
          record[:item][:status] = status.last if record
        else
          apply_output(type, data, event.class)
        end

        nil
      end

      private

      def apply_output(type, data, event_class)
        case type
        when "response.output_item.added", "response.output_item.done"
          return unavailable unless valid_index?(data[:output_index]) && data[:item].is_a?(Hash)

          replace_item(data[:output_index], data[:item])
        when
            "response.content_part.added",
            "response.content_part.done",
            "response.reasoning_summary_part.added",
            "response.reasoning_summary_part.done"
          summary = type.start_with?("response.reasoning_summary")
          index = data[summary ? :summary_index : :content_index]
          part = data[:part]
          return unavailable unless valid_index?(index) && part.is_a?(Hash)

          kind = summary || part[:type].to_s == "reasoning_text" ? "reasoning" : "message"
          record = item_for(data, kind)
          put_part(record, summary ? :summary : :content, index, part) if record
        when
            "response.function_call_arguments.delta",
            "response.function_call_arguments.done",
            "response.custom_tool_call_input.delta",
            "response.custom_tool_call_input.done",
            "response.mcp_call_arguments.delta",
            "response.mcp_call_arguments.done",
            "response.code_interpreter_call_code.delta",
            "response.code_interpreter_call_code.done"
          kind, field = case type
          when /function_call_arguments/
            ["function_call", :arguments]
          when /custom_tool_call_input/
            ["custom_tool_call", :input]
          when /mcp_call_arguments/
            ["mcp_call", :arguments]
          else
            ["code_interpreter_call", :code]
          end

          done = type.end_with?(".done")
          value = data[done ? field : :delta]
          return unavailable unless value.is_a?(String)

          record = item_for(data, kind)
          if record
            update_string(record[:item], field, value, done: done, nullable: field == :code, required: record[:full])
          end

        when
            "response.output_text.delta",
            "response.output_text.done",
            "response.refusal.delta",
            "response.refusal.done",
            "response.reasoning_text.delta",
            "response.reasoning_text.done",
            "response.reasoning_summary_text.delta",
            "response.reasoning_summary_text.done"
          summary = type.start_with?("response.reasoning_summary")
          reasoning = type.start_with?("response.reasoning")
          refusal = type.start_with?("response.refusal")
          field = refusal ? :refusal : :text
          done = type.end_with?(".done")
          value = data[done ? field : :delta]
          index = data[summary ? :summary_index : :content_index]
          return unavailable unless value.is_a?(String) && valid_index?(index)
          return unavailable unless data[:logprobs].nil? || data[:logprobs].is_a?(Array)

          record = item_for(data, reasoning ? "reasoning" : "message")
          return unless record

          kind = reasoning ? (summary ? "summary_text" : "reasoning_text") : (refusal ? "refusal" : "output_text")
          part = part_for(record, summary ? :summary : :content, index, kind)
          return unless part
          return unless update_string(part[:part], field, value, done: done, required: part[:full])

          if type.start_with?("response.output_text") && !data[:logprobs].nil?
            if done
              part[:part][:logprobs] = data[:logprobs]
            else
              old = part[:part][:logprobs]
              return unavailable unless old.nil? || old.is_a?(Array)

              (part[:part][:logprobs] ||= []).concat(data[:logprobs])
            end
          end

        when "response.output_text.annotation.added"
          index = data[:content_index]
          annotation_index = data[:annotation_index]
          unless valid_index?(index) && valid_index?(annotation_index) && data[:annotation].is_a?(Hash)
            return unavailable
          end

          record = item_for(data, "message")
          return unless record

          part = part_for(record, :content, index, "output_text")
          return unless part
          return unavailable if part[:part].key?(:annotations) && !part[:part][:annotations].is_a?(Array)

          part[:annotations][annotation_index] = data[:annotation]
          sync_array(part[:part][:annotations], part[:annotations], annotation_index)
        when
            "response.shell_call_command.added",
            "response.shell_call_command.delta",
            "response.shell_call_command.done"
          done = !type.end_with?(".delta")
          value = data[done ? :command : :delta]
          index = data[:command_index]
          return unavailable unless value.is_a?(String) && valid_index?(index)

          record = item_for(data, "shell_call", identity: false)
          return unless record

          if done
            record[:commands][index] = value
          else
            return unavailable if record[:commands].key?(index) && !record[:commands][index].is_a?(String)

            (record[:commands][index] ||= +"") << value
          end

          commands = record[:item].dig(:action, :commands)
          sync_array(commands, record[:commands], index)
          update_bound(record, data[:output_index])
        when "response.shell_call_output_content.delta", "response.shell_call_output_content.done"
          index = data[:command_index]
          done = type.end_with?(".done")
          value = data[done ? :output : :delta]
          return unavailable unless valid_index?(index)
          if done
            return unavailable unless value.is_a?(Array)
          else
            unless value.is_a?(Hash) &&
                value.all? { |key, entry| !%i[stdout stderr].include?(key) || entry.is_a?(String) }
              return unavailable
            end
          end

          record = item_for(data, "shell_call_output")
          return unless record

          bound = @command_bounds[record[:item][:call_id]]
          return unavailable if bound && index >= bound[:count]

          if done
            record[:content][index] = make_part({output: value}, full: false)
          else
            part = record[:content][index] ||= make_part({}, full: false)
            value.each do |key, entry|
              if %i[stdout stderr].include?(key)
                update_string(part[:part], key, entry, done: false)
              else
                part[:part][key] = entry
              end
            end
          end

        when "response.image_generation_call.partial_image"
          # Image bytes are deliberately not accumulated. Status remains useful.
          nil
        else
          if event_class.known_fields.key?(:output_index) &&
              type.end_with?(".added", ".delta", ".done", ".partial_image")
            unavailable
          end
        end
      end

      def item_for(data, kind, identity: true)
        index = data[:output_index]
        return unavailable unless valid_index?(index)

        record = @items[index]
        return unavailable if record && record[:kind] && record[:kind] != kind
        if identity
          id = data[:item_id]
          return unavailable unless id.is_a?(String)
          return unavailable if @ids.key?(id) && @ids[id] != index
          if record
            item = record[:item]
            if item.key?(:id)
              return unavailable unless item[:id] == id
            elsif record[:full] && !%w[function_call custom_tool_call].include?(kind)
              return unavailable
            end

            return unavailable if record[:bound_id] && record[:bound_id] != id
          end
        end

        record ||= (@items[index] = make_record({}, full: false))
        record[:kind] ||= kind
        if identity
          record[:bound_id] = data[:item_id]
          record[:item][:id] = data[:item_id] unless record[:full]
          @ids[data[:item_id]] = index
        end

        @phase = :provisional
        record
      end

      def replace_item(index, item)
        id = item[:id]
        return unavailable if id.is_a?(String) && @ids.key?(id) && @ids[id] != index

        if (old = @items[index])
          @ids.delete(old[:bound_id]) if old[:bound_id]
          call_id = old[:item][:call_id]
          @command_bounds.delete(call_id) if @command_bounds[call_id]&.fetch(:index) == index
        end

        record = @items[index] = make_record(item, full: true)
        @ids[id] = index if id.is_a?(String)
        update_bound(record, index)
        @phase = :provisional
      end

      def make_record(item, full:)
        kind = item[:type]&.to_s
        {
          item: item,
          full: full,
          kind: kind,
          bound_id: item[:id],
          content: part_collection?(kind, :content) ? indexed_parts(item[:content]) : {},
          summary: part_collection?(kind, :summary) ? indexed_parts(item[:summary]) : {},
          commands: kind == "shell_call" && item[:action].is_a?(Hash) && item[:action][:commands].is_a?(Array) ? item[
            :action
          ][:commands]
            .each_with_index
            .to_h { |value, index| [index, value] } : {}
        }
      end

      def indexed_parts(parts)
        return {} unless parts.is_a?(Array)

        parts.each_with_index.to_h { |part, index| [index, make_part(part, full: true)] }
      end

      def make_part(part, full:)
        {
          part: part,
          full: full,
          kind: part[:type]&.to_s,
          annotations: part[:type].to_s == "output_text" && part[:annotations].is_a?(Array) ? part[:annotations]
            .each_with_index
            .to_h { |value, index|
              [index, value]
            } : {}
        }
      end

      def part_for(record, collection, index, kind)
        part = record[collection][index]
        return unavailable if part && part[:kind] && part[:kind] != kind

        part ||= (record[collection][index] = make_part({}, full: false))
        part[:kind] ||= kind
        part
      end

      def put_part(record, collection, index, part)
        record[collection][index] = make_part(part, full: true)
        sync_array(record[:item][collection], record[collection], index) { |value| value[:part] }
      end

      # Grow only through actual contiguous observations, never through a hole.
      def sync_array(array, values, index)
        return unless array.is_a?(Array)

        if index < array.length
          value = values[index]
          array[index] = block_given? ? yield(value) : value
        end

        while values.key?(array.length)
          value = values[array.length]
          array << (block_given? ? yield(value) : value)
        end
      end

      def update_bound(record, index)
        return unless record[:kind] == "shell_call"

        call_id = record[:item][:call_id]
        commands = record[:item].dig(:action, :commands)
        return unless call_id.is_a?(String)

        if commands.is_a?(Array) && commands.length == record[:commands].length
          @command_bounds[call_id] = {index: index, count: commands.length}
        else
          @command_bounds.delete(call_id)
        end
      end

      def update_string(fields, field, value, done:, nullable: false, required: false)
        if done
          fields[field] = value
        else
          return unavailable if required && !fields.key?(field)

          old = fields[field]
          return unavailable if fields.key?(field) && !old.is_a?(String) && !(nullable && old.nil?)

          (fields[field] ||= +"") << value
        end

        true
      end

      def project_item(record)
        item = record[:item].dup
        %i[content summary].each do |collection|
          parts = record[collection]
          unless part_collection?(record[:kind], collection) &&
              (item[collection].is_a?(Array) || parts[0]&.fetch(:full))
            next
          end

          item[collection] = []
          while (part = parts[item[collection].length]) && part[:full]
            value = part[:part].dup
            if part[:kind] == "output_text" && (value[:annotations].is_a?(Array) || part[:annotations].key?(0))
              value[:annotations] = prefix(part[:annotations])
            end

            item[collection] << value
          end
        end

        if record[:kind] == "shell_call" && item.dig(:action, :commands).is_a?(Array)
          item[:action] = item[:action].dup
          item[:action][:commands] = prefix(record[:commands])
        end

        copy(item)
      end

      def prefix(values)
        result = []
        result << values[result.length] while values.key?(result.length)
        result
      end

      def detailed_item(index, record)
        item = record[:item].dup
        result = {output_index: index, item: item}
        %i[content summary].each do |collection|
          parts = record[collection]
          full_array = part_collection?(record[:kind], collection) && item[collection].is_a?(Array)
          next unless full_array || !parts.empty?

          item.delete(collection) if full_array
          key = record[:kind] == "shell_call_output" ? :command_index : (collection == :summary ? :summary_index : :content_index)
          result[collection] = parts.keys.sort.map do |part_index|
            part = parts.fetch(part_index)
            value = part[:part].dup
            if part[:kind] == "output_text" && (value[:annotations].is_a?(Array) || !part[:annotations].empty?)
              value.delete(:annotations)
              value[:annotations] = part[:annotations].keys.sort.map do |annotation_index|
                {annotation_index: annotation_index, annotation: part[:annotations].fetch(annotation_index)}
              end
            end

            {key => part_index, :part => value}
          end
        end

        if record[:kind] == "shell_call" && (item.dig(:action, :commands).is_a?(Array) || !record[:commands].empty?)
          item[:action] = item[:action].dup if item[:action].is_a?(Hash)
          item[:action]&.delete(:commands)
          result[:commands] = record[:commands].keys.sort.map do |command_index|
            {command_index: command_index, command: record[:commands].fetch(command_index)}
          end
        end

        result
      end

      def observed_text(records)
        records
          .flat_map do |record|
            next [] unless record[:kind] == "message"

            record[:content].keys.sort.filter_map do |index|
              part = record[:content].fetch(index)
              text = part[:part][:text]
              text if part[:kind] == "output_text" && text.is_a?(String)
            end
          end
          .join
      end

      def part_collection?(kind, collection)
        kind == "reasoning" || (kind == "message" && collection == :content)
      end

      def valid_index?(index)
        index.is_a?(Integer) && index >= 0
      end

      def unavailable
        reset
        @phase = :unavailable
        nil
      end

      # BaseModel's recursive representation retains strings. Both incoming data
      # and read views must cross this copy boundary before their owner can mutate.
      def copy(value)
        data = OpenAI::Internal::Type::BaseModel.recursively_to_h(value, convert: false)
        data = parse_json(generate_json(data))
        return data unless value.is_a?(OpenAI::Internal::Type::BaseModel)

        OpenAI::Internal::Type::Converter.coerce(value.class, data)
      rescue SystemStackError
        raise SessionError, "Could not copy the Responses WebSocket event.", cause: nil
      end
    end
  end
end
