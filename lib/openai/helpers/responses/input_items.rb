# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class << self
        # Converts mixed Responses input and output items into replayable input models.
        #
        # Items that cannot be replayed without changing their meaning are omitted.
        # Existing valid input models are reused when no normalization is necessary.
        #
        # @api public
        # @param items [Enumerable<OpenAI::Models::Responses::ResponseInputItem, OpenAI::Models::Responses::ResponseOutputItem, OpenAI::Models::Responses::ResponseItem, Hash>, OpenAI::Models::Responses::ResponseItemList, OpenAI::Internal::CursorPage<OpenAI::Models::Responses::ResponseItem>]
        # @return [Array<OpenAI::Models::Responses::ResponseInputItem>]
        def to_input_items(items)
          collection = if OpenAI::Responses::ResponseItemList === items
            items.data
          elsif OpenAI::Internal::CursorPage === items
            items.to_enum
          else
            items
          end

          unless Enumerable === collection
            raise TypeError.new("Response items must be enumerable or a response item list")
          end

          collection.filter_map { |item| to_input_item(item) }
        end

        # Converts one stored Responses item into its corresponding input model.
        #
        # Returns nil for known item states that cannot be replayed safely.
        #
        # @api public
        # @param item [OpenAI::Models::Responses::ResponseInputItem, OpenAI::Models::Responses::ResponseOutputItem, OpenAI::Models::Responses::ResponseItem, Hash]
        # @return [OpenAI::Models::Responses::ResponseInputItem, nil]
        # @raise [TypeError] if the item or its discriminator is unsupported
        def to_input_item(item)
          serialized = case item
          in OpenAI::Internal::Type::BaseModel
            unless supported_response_history_model?(item)
              raise TypeError.new("Response item must be a Responses model or hash")
            end

            OpenAI::Internal::Type::Converter.dump(item.class, item)
          in Hash
            item
          else
            raise TypeError.new("Response item must be a model or hash")
          end

          value = normalize_response_history_value(serialized)
          type = value[:type]
          if String === type
            unless String.instance_method(:valid_encoding?).bind_call(type)
              raise TypeError.new("Unsupported response item type")
            end

            type = String.instance_method(:to_sym).bind_call(type)
          end

          typed_item_reference = item.is_a?(OpenAI::Responses::ResponseInputItem::ItemReference)
          if type.nil? && !easy_input_message?(value) && !item_reference?(value) && !typed_item_reference
            raise TypeError.new("Unsupported response item without a type")
          end

          if !type.nil? && !supported_response_input_type?(type)
            raise TypeError.new("Unsupported response item type")
          end

          unless valid_replay_links?(value, type)
            raise TypeError.new("Unsupported nested response item discriminator")
          end

          defaulted_image_detail = default_input_image_details!(value)
          canonicalized_caller = canonicalize_caller!(value, type)
          filtered_source = normalize_response_history_value(value)
          changed = value.key?(:created_by) || canonicalized_caller || defaulted_image_detail
          value.delete(:created_by)
          source_has_sdk_parsed = contains_sdk_parsed?(item)
          removed_sdk_parsed = remove_sdk_parsed!(value)
          changed ||= source_has_sdk_parsed
          changed ||= removed_sdk_parsed

          case type
          when :additional_tools
            unless OpenAI::Responses::ResponseOutputItem::AdditionalTools::Role
                .values
                .include?(value[:role].to_s.to_sym)
              raise TypeError.new("Invalid response item type: #{type}")
            end

            unless value[:role].to_s == "developer"
              validate_filtered_item!(OpenAI::Responses::ResponseOutputItem::AdditionalTools, filtered_source, type)
              return nil
            end

          when :computer_call_output
            if value[:status].to_s == "failed"
              validate_filtered_item!(OpenAI::Responses::ResponseComputerToolCallOutputItem, filtered_source, type)
              return nil
            end

          when :custom_tool_call
            if value.key?(:status)
              unless OpenAI::Responses::ResponseCustomToolCallItem::Status
                  .values
                  .include?(value.fetch(:status).to_s.to_sym)
                raise TypeError.new("Invalid response item type: #{type}")
              end

              changed = true
              value.delete(:status)
            end

          when :custom_tool_call_output
            if value.key?(:status)
              unless OpenAI::Responses::ResponseCustomToolCallOutputItem::Status
                  .values
                  .include?(value.fetch(:status).to_s.to_sym)
                raise TypeError.new("Invalid response item type: #{type}")
              end

              if value.fetch(:status).to_s != "completed"
                validate_filtered_item!(OpenAI::Responses::ResponseCustomToolCallOutputItem, filtered_source, type)
                return nil
              end
            end

            changed ||= value.key?(:status)
            value.delete(:status)
          when :shell_call_output
            if value[:output].is_a?(Array)
              value.fetch(:output).each do |chunk|
                next unless chunk.is_a?(Hash)

                changed ||= chunk.key?(:created_by)
                chunk.delete(:created_by)
              end
            end
          end

          target = response_input_target(value, type)
          state = OpenAI::Internal::Type::Converter.new_coerce_state
          normalized = OpenAI::Internal::Type::Converter.coerce(target, value, state: state)

          if missing_nested_discriminator?(value, normalized)
            raise TypeError.new("Unsupported nested response item discriminator")
          end

          # Function calls require a response-only `parsed` field in their shared model,
          # but replay intentionally strips it before validating the request shape.
          allowed_missing_fields = type == :function_call ? 1 : 0
          allowed_missing_fields += explicit_null_input_image_details(value)
          exactness = state.fetch(:exactness)
          allowed_approximate_fields = allowed_explicit_nulls(value, normalized)
          if state.fetch(:error) ||
              exactness.fetch(:no) > allowed_missing_fields ||
              exactness.fetch(:maybe) > allowed_approximate_fields
            raise TypeError.new("Invalid response item type: #{type}")
          end

          unless OpenAI::Responses::ResponseInputItem === normalized
            raise TypeError.new("Unsupported response item type: #{type}")
          end

          return item if !changed && OpenAI::Responses::ResponseInputItem === item

          normalized
        end

        private

        def supported_response_history_model?(value)
          OpenAI::Responses::ResponseInputItem === value ||
            OpenAI::Responses::ResponseOutputItem === value ||
            OpenAI::Responses::ResponseItem === value
        end

        def normalize_response_history_value(value)
          case value
          in Hash
            value.each_with_object({}) do |(key, nested), normalized|
              unless String === key || Symbol === key
                raise TypeError.new("Unsupported response item hash key type")
              end

              normalized_key = if String === key
                unless String.instance_method(:valid_encoding?).bind_call(key)
                  raise TypeError.new("Unsupported response item hash key type")
                end

                String.instance_method(:to_sym).bind_call(key)
              else
                key
              end

              if normalized.key?(normalized_key)
                raise TypeError.new("Conflicting response item hash keys")
              end

              normalized.store(normalized_key, normalize_response_history_value(nested))
            end

          in Array
            value.map { |nested| normalize_response_history_value(nested) }
          in OpenAI::Internal::Type::BaseModel
            serialized = OpenAI::Internal::Type::Converter.dump(value.class, value)
            normalize_response_history_value(serialized)
          else
            value
          end
        end

        def response_input_target(value, type)
          if type.nil?
            return OpenAI::Responses::EasyInputMessage if easy_input_message?(value)

            return OpenAI::Responses::ResponseInputItem::ItemReference
          end

          if type == :message
            if value[:content] == [] && valid_message_metadata?(value, :output)
              return OpenAI::Responses::ResponseOutputMessage
            end

            content_family = value[:content] == [] ? :input : message_content_family(value[:content])
            raise TypeError.new("Unsupported response message content") unless content_family
            unless valid_message_content?(value.fetch(:content), content_family)
              raise TypeError.new("Unsupported response message content")
            end

            unless valid_message_metadata?(value, content_family)
              raise TypeError.new("Unsupported response message metadata")
            end

            if content_family == :output
              return OpenAI::Responses::ResponseOutputMessage
            end

            return OpenAI::Responses::EasyInputMessage
          end

          OpenAI::Responses::ResponseInputItem
        end

        def message_content_family(content)
          return :input if content.is_a?(String)
          return nil unless content.is_a?(Array) && !content.empty?

          families = content.map do |item|
            next unless item.is_a?(Hash)

            type = item[:type].to_s
            if %w[input_text input_image input_file].include?(type)
              :input
            elsif %w[output_text refusal].include?(type)
              :output
            end
          end

          return nil if families.include?(nil) || families.uniq.length != 1

          families.fetch(0)
        end

        def valid_message_content?(content, family)
          return family == :input if content.is_a?(String)

          content.all? do |item|
            case item[:type].to_s
            when "input_text"
              family == :input && item[:text].is_a?(String)
            when "input_image"
              family == :input &&
                (!item.key?(:detail) ||
                  item[:detail].nil? ||
                  OpenAI::Responses::ResponseInputImage::Detail.values.include?(item[:detail].to_s.to_sym)) &&
                valid_image_source?(item)
            when "input_file"
              family == :input && valid_file_source?(item)
            when "output_text"
              family == :output && item[:text].is_a?(String) && valid_annotations?(item[:annotations])
            when "refusal"
              family == :output && item[:refusal].is_a?(String)
            else
              false
            end
          end
        end

        def easy_input_message?(value)
          return false unless value.key?(:role) && value.key?(:content)
          return false unless OpenAI::Responses::EasyInputMessage::Role.values.include?(value[:role].to_s.to_sym)
          return false unless easy_input_content?(value.fetch(:content))
          return false unless valid_input_message_metadata?(value)
          return true unless value.key?(:phase) && !value[:phase].nil?

          OpenAI::Responses::EasyInputMessage::Phase.values.include?(value[:phase].to_s.to_sym)
        end

        def item_reference?(value)
          keys = value.keys.sort

          value[:id].is_a?(String) &&
            (keys == [:id] || (keys == [:id, :type] && value[:type].nil?))
        end

        def valid_message_metadata?(value, content_family)
          roles = if content_family == :output
            [:assistant]
          else
            OpenAI::Responses::EasyInputMessage::Role.values
          end

          return false unless roles.include?(value[:role].to_s.to_sym)
          if content_family == :output
            return false unless value[:id].is_a?(String)
            unless OpenAI::Responses::ResponseOutputMessage::Status.values.include?(value[:status].to_s.to_sym)
              return false
            end
          else
            return false unless valid_input_message_metadata?(value)
          end

          return true unless value.key?(:phase) && !value[:phase].nil?

          OpenAI::Responses::EasyInputMessage::Phase.values.include?(value[:phase].to_s.to_sym)
        end

        def easy_input_content?(content)
          return true if content.is_a?(String)
          return false unless content.is_a?(Array)
          return true if content.empty?

          message_content_family(content) == :input && valid_message_content?(content, :input)
        end

        def valid_replay_links?(value, type)
          if caller_item_type?(type)
            return false if value.key?(:caller) && !valid_caller_discriminator?(value.fetch(:caller))
            return false if value.key?(:caller_) && !valid_caller_discriminator?(value.fetch(:caller_))
          end

          if %i[function_call_output custom_tool_call_output].include?(type)
            return false unless valid_tool_output_discriminators?(value[:output])
          end

          if type == :computer_call_output
            if value[:output].is_a?(Hash) && value[:output].key?(:type)
              return false if value[:output][:type].to_s != "computer_screenshot"
              return false unless valid_image_source?(value[:output])
            end

            return false if value[:output].is_a?(Hash) && !value[:output].key?(:type)
          end

          if type == :apply_patch_call && value[:operation].is_a?(Hash)
            return false unless %w[create_file delete_file update_file].include?(value[:operation][:type].to_s)
          end

          if type == :additional_tools && value[:tools].is_a?(Array)
            unless value.fetch(:tools).all? do |tool|
                tool.is_a?(Hash) && supported_union_type?(OpenAI::Responses::Tool, tool[:type])
              end

              return false
            end
          end

          return true unless type == :shell_call_output
          return true unless value[:output].is_a?(Array)

          value.fetch(:output).all? do |chunk|
            !chunk.is_a?(Hash) || valid_shell_outcome_discriminator?(chunk[:outcome])
          end
        end

        def canonicalize_caller!(value, type)
          return false unless caller_item_type?(type) && value.key?(:caller_)
          if value.key?(:caller)
            raise TypeError.new("Conflicting response item caller fields")
          end

          value.store(:caller, value.delete(:caller_))
          true
        end

        def caller_item_type?(type)
          %i[
            function_call
            function_call_output
            shell_call
            shell_call_output
            apply_patch_call
            apply_patch_call_output
            custom_tool_call
            custom_tool_call_output
          ]
            .include?(type)
        end

        def valid_caller_discriminator?(caller)
          !caller.is_a?(Hash) || %w[direct program].include?(caller[:type].to_s)
        end

        def valid_shell_outcome_discriminator?(outcome)
          !outcome.is_a?(Hash) || %w[timeout exit].include?(outcome[:type].to_s)
        end

        def valid_input_message_metadata?(value)
          return false if value.key?(:id) && !value[:id].is_a?(String)
          return true unless value.key?(:status) && !value[:status].nil?

          OpenAI::Responses::ResponseInputMessageItem::Status.values.include?(value[:status].to_s.to_sym)
        end

        def valid_tool_output_discriminators?(output)
          return true if output.is_a?(String)
          return true unless output.is_a?(Array)

          output.all? do |item|
            next true unless item.is_a?(Hash)

            case item[:type].to_s
            when "input_text"
              true
            when "input_image"
              valid_image_source?(item)
            when "input_file"
              valid_file_source?(item)
            else
              false
            end
          end
        end

        def valid_image_source?(value)
          [value[:file_id], value[:image_url]].count { |source| source.is_a?(String) } == 1
        end

        def valid_file_source?(value)
          [value[:file_data], value[:file_id], value[:file_url]].count { |source| source.is_a?(String) } == 1
        end

        def valid_annotations?(annotations)
          return false unless annotations.is_a?(Array)

          annotations.all? do |annotation|
            annotation.is_a?(Hash) &&
              %w[file_citation url_citation container_file_citation file_path].include?(annotation[:type].to_s)
          end
        end

        def validate_filtered_item!(target, value, type)
          state = OpenAI::Internal::Type::Converter.new_coerce_state
          normalized = OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
          exactness = state.fetch(:exactness)
          unless state.fetch(:error) ||
              exactness.fetch(:no).positive? ||
              exactness.fetch(:maybe) > allowed_explicit_nulls(value, normalized) ||
              missing_nested_discriminator?(value, normalized)
            return
          end

          raise TypeError.new("Invalid response item type: #{type}")
        end

        # The converter intentionally accepts omitted constant fields when it can infer a
        # model from shape. That is useful for constructors, but replaying raw history must
        # not guess which nested response variant the caller meant.
        def missing_nested_discriminator?(value, normalized, nested: false)
          case [value, normalized]
          in [Hash, OpenAI::Internal::Type::BaseModel]
            if nested
              missing_constant = normalized.class.known_fields.any? do |name, field|
                field.fetch(:required) &&
                  field.fetch(:const) &&
                  !value.key?(name) &&
                  !value.key?(field.fetch(:api_name))
              end

              return true if missing_constant
            end

            value.any? do |key, child|
              field_name, field = normalized.class.known_fields.find do |known_name, known_field|
                known_name == key || known_field.fetch(:api_name) == key
              end

              next false unless field

              missing_nested_discriminator?(child, normalized.to_h[field_name], nested: true)
            end

          in [Array, Array]
            value.zip(normalized).any? do |child, coerced|
              missing_nested_discriminator?(child, coerced, nested: true)
            end
          else
            false
          end
        end

        def allowed_explicit_nulls(value, normalized)
          case [value, normalized]
          in [Hash, OpenAI::Internal::Type::BaseModel]
            value.sum do |key, nested|
              name = key.is_a?(String) ? key.to_sym : key
              field_name, field = normalized.class.known_fields.find do |known_name, known_field|
                known_name == name || known_field.fetch(:api_name) == name
              end

              next 0 unless field
              if nested.nil?
                next !field.fetch(:required) && !field.fetch(:nilable) ? 1 : 0
              end

              allowed_explicit_nulls(nested, normalized.to_h[field_name])
            end

          in [Array, Array]
            value.zip(normalized).sum { |nested, coerced| allowed_explicit_nulls(nested, coerced) }
          else
            0
          end
        end

        def default_input_image_details!(value)
          content = input_image_content_list(value)
          return false unless content

          changed = false
          content.each do |item|
            next unless item.is_a?(Hash) && item[:type].to_s == "input_image"
            next if item.key?(:detail)

            item.store(:detail, :auto)
            changed = true
          end

          changed
        end

        def explicit_null_input_image_details(value)
          content = input_image_content_list(value)
          return 0 unless content

          content.count do |item|
            item.is_a?(Hash) &&
              item[:type].to_s == "input_image" &&
              item.key?(:detail) &&
              item[:detail].nil?
          end
        end

        def input_image_content_list(value)
          type = value[:type].to_s
          return value[:content] if (type.empty? || type == "message") && value[:content].is_a?(Array)
          return value[:output] if type == "custom_tool_call_output" && value[:output].is_a?(Array)
        end

        def remove_sdk_parsed!(value)
          type = value[:type]
          type = type.to_sym if type.is_a?(String)
          changed = type == :function_call && value.key?(:parsed)
          value.delete(:parsed) if changed

          if type == :message && value[:content].is_a?(Array)
            value.fetch(:content).each do |content|
              next unless content.is_a?(Hash)
              next unless content[:type].to_s == "output_text" && content.key?(:parsed)

              content.delete(:parsed)
              changed = true
            end
          end

          changed
        end

        def contains_sdk_parsed?(value)
          case value
          in OpenAI::Internal::Type::BaseModel
            found = value.class.known_fields.key?(:parsed) && value.to_h.key?(:parsed)
            if value.is_a?(OpenAI::Responses::ResponseOutputMessage) && value.to_h[:content].is_a?(Array)
              value.to_h.fetch(:content).each do |content|
                content_has_parsed = case content
                in OpenAI::Internal::Type::BaseModel
                  content.class.known_fields.key?(:parsed) && content.to_h.key?(:parsed)
                in Hash
                  type = content[:type] || content["type"]
                  type.to_s == "output_text" && (content.key?(:parsed) || content.key?("parsed"))
                else
                  false
                end

                found ||= content_has_parsed
              end
            end

            found
          in Hash
            type = value[:type]
            type = type.to_sym if type.is_a?(String)
            found = type == :function_call && value.key?(:parsed)
            if type == :message && value[:content].is_a?(Array)
              value.fetch(:content).each do |content|
                next unless content.is_a?(Hash)

                found ||= content[:type].to_s == "output_text" && content.key?(:parsed)
              end
            end

            found
          else
            false
          end
        end

        def supported_response_input_type?(type)
          supported_union_type?(OpenAI::Responses::ResponseInputItem, type)
        end

        def supported_union_type?(union, type)
          type = type.to_sym if type.is_a?(String)
          union.variants.any? do |variant|
            next false unless variant.respond_to?(:known_fields)

            field = variant.known_fields[:type]
            next false unless field
            next true if field.fetch(:const) == type

            target = field.fetch(:type_fn).call
            target.respond_to?(:values) && target.values.include?(type)
          end
        end
      end
    end
  end
end
