# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      DISCRIMINATOR_COLLECTION_KEYS = %i[allowed_callers search_content_types].freeze
      private_constant :DISCRIMINATOR_COLLECTION_KEYS

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

            OpenAI::Internal::Type::Converter.dump(core_class(item), item)
          in Hash
            item
          else
            raise TypeError.new("Response item must be a model or hash")
          end

          value = normalize_response_history_value(serialized, discriminator_context: :item)
          type = value[:type]
          if String === type
            unless String.instance_method(:valid_encoding?).bind_call(type)
              raise TypeError.new("Unsupported response item type")
            end

            type = String.instance_method(:to_sym).bind_call(type)
          end

          typed_item_reference = OpenAI::Responses::ResponseInputItem::ItemReference === item
          if NilClass === type && !easy_input_message?(value) && !item_reference?(value) && !typed_item_reference
            raise TypeError.new("Unsupported response item without a type")
          end

          if !(NilClass === type) && !supported_response_input_type?(type)
            raise TypeError.new("Unsupported response item type")
          end

          unless valid_replay_links?(value, type)
            raise TypeError.new("Unsupported nested response item discriminator")
          end

          defaulted_image_detail = default_input_image_details!(value)
          canonicalized_caller = canonicalize_caller!(value, type)
          filtered_source = normalize_response_history_value(value, discriminator_context: :item)
          changed = value.key?(:created_by) || canonicalized_caller || defaulted_image_detail
          value.delete(:created_by)
          source_has_sdk_parsed = if OpenAI::Internal::Type::BaseModel === item
            contains_sdk_parsed?(item)
          else
            contains_sdk_parsed?(value)
          end

          removed_sdk_parsed = remove_sdk_parsed!(value)
          changed ||= source_has_sdk_parsed
          changed ||= removed_sdk_parsed

          case type
          when :additional_tools
            unless OpenAI::Responses::ResponseOutputItem::AdditionalTools::Role
                .values
                .include?(safe_symbol(value[:role]))
              raise TypeError.new("Invalid response item type: #{type}")
            end

            unless safe_string(value[:role]) == "developer"
              validate_filtered_item!(OpenAI::Responses::ResponseOutputItem::AdditionalTools, filtered_source, type)
              return nil
            end

          when :computer_call_output
            if value.key?(:status) &&
                !OpenAI::Responses::ResponseComputerToolCallOutputItem::Status
                  .values
                  .include?(safe_symbol(value[:status]))
              raise TypeError.new("Invalid response item type: #{type}")
            end

            if safe_string(value[:status]) == "failed"
              validate_filtered_item!(OpenAI::Responses::ResponseComputerToolCallOutputItem, filtered_source, type)
              return nil
            end

          when :custom_tool_call
            if value.key?(:status)
              unless OpenAI::Responses::ResponseCustomToolCallItem::Status
                  .values
                  .include?(safe_symbol(value.fetch(:status)))
                raise TypeError.new("Invalid response item type: #{type}")
              end

              changed = true
              value.delete(:status)
            end

          when :custom_tool_call_output
            if value.key?(:status)
              unless OpenAI::Responses::ResponseCustomToolCallOutputItem::Status
                  .values
                  .include?(safe_symbol(value.fetch(:status)))
                raise TypeError.new("Invalid response item type: #{type}")
              end

              if safe_string(value.fetch(:status)) != "completed"
                validate_filtered_item!(OpenAI::Responses::ResponseCustomToolCallOutputItem, filtered_source, type)
                return nil
              end
            end

            changed ||= value.key?(:status)
            value.delete(:status)
          when :shell_call_output
            if Array === value[:output]
              value.fetch(:output).each do |chunk|
                next unless Hash === chunk

                changed ||= chunk.key?(:created_by)
                chunk.delete(:created_by)
              end
            end
          end

          validate_tool_search_execution!(value, type)
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

        def core_class(value)
          Object.instance_method(:class).bind_call(value)
        end

        def safe_string(value)
          symbol = safe_symbol(value)
          return unless symbol

          Symbol.instance_method(:to_s).bind_call(symbol)
        end

        def safe_symbol(value)
          return value if Symbol === value
          return unless String === value
          return unless String.instance_method(:valid_encoding?).bind_call(value)

          String.instance_method(:to_sym).bind_call(value)
        end

        def supported_response_history_model?(value)
          OpenAI::Responses::ResponseInputItem === value ||
            OpenAI::Responses::ResponseOutputItem === value ||
            OpenAI::Responses::ResponseItem === value
        end

        def normalize_response_history_value(value, discriminator_context: false)
          case value
          in Hash
            normalized = {}
            Hash.instance_method(:each).bind_call(value) do |key, nested|
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

              normalized_value = if opaque_history_value?(value, normalized_key, discriminator_context)
                nested
              elsif hash_of_history_value?(value, normalized_key, discriminator_context)
                normalize_hash_of_value(nested)
              elsif discriminator_context &&
                  discriminator_collection_key?(value, normalized_key, discriminator_context)
                if NilClass === nested
                  nested
                elsif Array === nested
                  normalize_discriminator_collection(nested)
                else
                  raise TypeError.new("Invalid response item type")
                end
              elsif discriminator_context &&
                  discriminator_key?(value, normalized_key, discriminator_context) &&
                  String === nested
                unless String.instance_method(:valid_encoding?).bind_call(nested)
                  raise TypeError.new("Invalid response item type")
                end

                plain_string(nested)
              elsif discriminator_context &&
                  discriminator_key?(value, normalized_key, discriminator_context) &&
                  unsupported_discriminator_value?(normalized_key, nested)
                raise TypeError.new("Invalid response item type")
              else
                normalize_response_history_value(
                  nested,
                  discriminator_context: typed_child_context(value, normalized_key, discriminator_context)
                )
              end

              normalized.store(normalized_key, normalized_value)
            end

            normalized

          in Array
            normalized = []
            Array.instance_method(:each).bind_call(value) do |nested|
              normalized << normalize_response_history_value(nested, discriminator_context: discriminator_context)
            end

            normalized

          in OpenAI::Internal::Type::BaseModel
            serialized = OpenAI::Internal::Type::Converter.dump(core_class(value), value)
            normalize_response_history_value(serialized, discriminator_context: discriminator_context)
          else
            value
          end
        end

        def opaque_history_value?(container, key, context)
          return true if key == :input_schema
          if key == :arguments
            return safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type")) == :tool_search_call
          end

          if key == :content
            return safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type")) == :mcp_tool_execution_error
          end

          context == :mcp_list_tool &&
            key == :annotations &&
            (hash_key?(container, :input_schema) || hash_key?(container, "input_schema"))
        end

        def hash_of_history_value?(container, key, context)
          type = safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type"))
          case type
          when :exec
            context == :typed && key == :env
          when :function
            if context == :namespace_tool
              return key == :output_schema
            end

            %i[response_tool tool_search_tool].include?(context) &&
              %i[output_schema parameters].include?(key)
          when :mcp
            %i[response_tool tool_search_tool].include?(context) && key == :headers
          when nil
            context == :file_search_result && key == :attributes
          else
            false
          end
        end

        def normalize_hash_of_value(value)
          return value if NilClass === value
          unless Hash === value
            raise TypeError.new("Invalid response item type")
          end

          normalized = {}
          Hash.instance_method(:each).bind_call(value) do |key, nested|
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

            normalized.store(normalized_key, nested)
          end

          normalized
        end

        def hash_key?(value, key)
          Hash.instance_method(:key?).bind_call(value, key)
        end

        def hash_value(value, key)
          Hash.instance_method(:[]).bind_call(value, key)
        end

        def existing_hash_value(value, key)
          return unless hash_key?(value, key)

          hash_value(value, key)
        end

        def typed_child_context(container, key, context)
          return unless context
          return if %i[mcp_require_approval shell_call_action web_search_filters].include?(context)
          return :typed if context == :shell_output_chunk && key == :outcome

          type = safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type"))
          if NilClass === type
            if context == :item &&
                key == :content &&
                (hash_key?(container, :role) || hash_key?(container, "role"))
              return :typed
            end

            return :typed if context == :web_search_action && key == :sources

            return
          end

          case type
          when :additional_tools
            return :response_tool if key == :tools
          when :namespace
            return :namespace_tool if key == :tools
          when :tool_search_output
            return :tool_search_tool if key == :tools
          when :apply_patch_call
            return :typed if %i[caller caller_ operation].include?(key)
          when :apply_patch_call_output, :custom_tool_call, :function_call
            return :typed if %i[caller caller_].include?(key)
          when :auto
            return :typed if key == :network_policy
          when :code_interpreter
            return :typed if key == :container
          when :code_interpreter_call
            return :typed if key == :outputs
          when :computer_call
            return :typed if %i[action actions].include?(key)
          when :computer_call_output
            return :typed if key == :output
          when :container_auto
            return :typed if %i[network_policy skills].include?(key)
          when :custom
            return :typed if key == :format
          when :custom_tool_call_output, :function_call_output, :shell_call_output
            return :shell_output_chunk if type == :shell_call_output && key == :output
            return :typed if %i[caller caller_ output].include?(key)
          when :and, :or
            return :typed if key == :filters
          when :file_search
            return :ranking_options if key == :ranking_options
            return :typed if key == :filters
          when :file_search_call
            return :file_search_result if key == :results
          when :inline
            return :typed if key == :source
          when :input_file, :input_image, :input_text
            return :prompt_cache_breakpoint if key == :prompt_cache_breakpoint
          when :local_shell_call, :web_search_call
            return :web_search_action if type == :web_search_call && key == :action
            return :typed if key == :action
          when :mcp
            return :mcp_require_approval if key == :require_approval
          when :mcp_call
            return :typed if key == :error
          when :mcp_list_tools
            return :mcp_list_tool if key == :tools
          when :message
            return :typed if key == :content
          when :output_text
            return :typed if key == :annotations
          when :reasoning
            return :typed if %i[content summary].include?(key)
          when :search
            return :typed if key == :sources
          when :shell
            return :typed if key == :environment
          when :shell_call
            return :shell_call_action if key == :action
            return :typed if %i[caller caller_ environment].include?(key)
          when :web_search, :web_search_2025_08_26
            return :web_search_filters if key == :filters
            return :typed if key == :user_location
          when :web_search_preview, :web_search_preview_2025_03_11
            return :typed if key == :user_location
          end

          nil
        end

        def discriminator_key?(container, key, context)
          return key == :ranker if context == :ranking_options
          return key == :mode if context == :prompt_cache_breakpoint
          return false if %i[mcp_require_approval shell_call_action web_search_filters].include?(context)

          type = safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type"))
          if key == :type
            return %i[
              item
              message_content
              namespace_tool
              response_tool
              tool_search_tool
              typed
              web_search_action
            ]
              .include?(context)
          end

          case type
          when nil
            if context == :item
              return %i[phase role].include?(key) &&
                (hash_key?(container, :content) || hash_key?(container, "content"))
            end

            false
          when :additional_tools
            key == :role
          when :message
            %i[phase role status].include?(key)
          when :input_file, :input_image
            key == :detail
          when :tool_search, :tool_search_call, :tool_search_output
            %i[execution status].include?(key)
          when
              :apply_patch_call,
              :apply_patch_call_output,
              :code_interpreter_call,
              :computer_call,
              :computer_call_output,
              :custom_tool_call,
              :custom_tool_call_output,
              :file_search_call,
              :function_call,
              :function_call_output,
              :image_generation_call,
              :local_shell_call,
              :local_shell_call_output,
              :mcp_call,
              :program_output,
              :reasoning,
              :shell_call,
              :shell_call_output,
              :web_search_call
            key == :status
          when :image_generation
            %i[action background input_fidelity model moderation output_format quality size].include?(key)
          when :auto, :container_auto
            key == :memory_limit
          when :base64, :inline
            key == :media_type
          when :mcp
            %i[connector_id require_approval].include?(key)
          when
              :web_search,
              :web_search_2025_08_26,
              :web_search_preview,
              :web_search_preview_2025_03_11
            key == :search_context_size
          when :computer_use_preview
            key == :environment
          when :click
            key == :button
          when :grammar
            key == :syntax
          else
            false
          end
        end

        def discriminator_collection_key?(container, key, _context)
          return false unless DISCRIMINATOR_COLLECTION_KEYS.include?(key)

          type = safe_symbol(existing_hash_value(container, :type) || existing_hash_value(container, "type"))
          if key == :allowed_callers
            return %i[apply_patch code_interpreter custom function mcp shell].include?(type)
          end

          %i[web_search_preview web_search_preview_2025_03_11].include?(type)
        end

        def unsupported_discriminator_value?(key, value)
          return false if Symbol === value
          return false if NilClass === value
          return false if Integer === value
          return false if Float === value
          return false if TrueClass === value
          return false if FalseClass === value
          return false if key == :require_approval && Hash === value

          true
        end

        def plain_string(value)
          exact_string = Object.instance_method(:instance_of?).bind_call(value, String)
          singleton_methods = Object.instance_method(:singleton_methods).bind_call(value)
          return value if exact_string && singleton_methods.empty?

          String.new(value)
        end

        def normalize_discriminator_collection(value)
          normalized = []
          Array.instance_method(:each).bind_call(value) do |item|
            if Symbol === item
              normalized << item
              next
            end

            unless String === item && String.instance_method(:valid_encoding?).bind_call(item)
              raise TypeError.new("Invalid response item type")
            end

            normalized << plain_string(item)
          end

          normalized
        end

        def validate_tool_search_execution!(value, type)
          return unless type == :tool_search_call && value.key?(:execution)
          return if NilClass === value[:execution] || safe_symbol(value[:execution])

          raise TypeError.new("Invalid response item type: tool_search_call")
        end

        def response_input_target(value, type)
          if NilClass === type
            return OpenAI::Responses::EasyInputMessage if easy_input_message?(value)

            return OpenAI::Responses::ResponseInputItem::ItemReference
          end

          if type == :message
            empty_content = Array === value[:content] && value[:content].empty?
            if empty_content && valid_message_metadata?(value, :output)
              return OpenAI::Responses::ResponseOutputMessage
            end

            content_family = empty_content ? :input : message_content_family(value[:content])
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
          return :input if String === content
          return nil unless Array === content && !content.empty?

          families = content.map do |item|
            next unless Hash === item

            type = safe_string(item[:type])
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
          return family == :input if String === content

          content.all? do |item|
            case safe_string(item[:type])
            when "input_text"
              family == :input && String === item[:text]
            when "input_image"
              family == :input &&
                (!item.key?(:detail) ||
                  NilClass === item[:detail] ||
                  OpenAI::Responses::ResponseInputImage::Detail.values.include?(safe_symbol(item[:detail]))) &&
                valid_image_source?(item)
            when "input_file"
              family == :input && valid_file_source?(item)
            when "output_text"
              family == :output && String === item[:text] && valid_annotations?(item[:annotations])
            when "refusal"
              family == :output && String === item[:refusal]
            else
              false
            end
          end
        end

        def easy_input_message?(value)
          return false unless value.key?(:role) && value.key?(:content)
          return false unless OpenAI::Responses::EasyInputMessage::Role.values.include?(safe_symbol(value[:role]))
          return false unless easy_input_content?(value.fetch(:content))
          return false unless valid_input_message_metadata?(value)
          return true unless value.key?(:phase) && !(NilClass === value[:phase])

          OpenAI::Responses::EasyInputMessage::Phase.values.include?(safe_symbol(value[:phase]))
        end

        def item_reference?(value)
          keys = value.keys.sort

          String === value[:id] &&
            (keys == [:id] || (keys == [:id, :type] && NilClass === value[:type]))
        end

        def valid_message_metadata?(value, content_family)
          roles = if content_family == :output
            [:assistant]
          else
            OpenAI::Responses::EasyInputMessage::Role.values
          end

          return false unless roles.include?(safe_symbol(value[:role]))
          if content_family == :output
            return false unless String === value[:id]
            unless OpenAI::Responses::ResponseOutputMessage::Status.values.include?(safe_symbol(value[:status]))
              return false
            end
          else
            return false unless valid_input_message_metadata?(value)
          end

          return true unless value.key?(:phase) && !(NilClass === value[:phase])

          OpenAI::Responses::EasyInputMessage::Phase.values.include?(safe_symbol(value[:phase]))
        end

        def easy_input_content?(content)
          return true if String === content
          return false unless Array === content
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
            if Hash === value[:output] && value[:output].key?(:type)
              return false if safe_string(value[:output][:type]) != "computer_screenshot"
              return false unless valid_image_source?(value[:output])
            end

            return false if Hash === value[:output] && !value[:output].key?(:type)
          end

          if type == :apply_patch_call && Hash === value[:operation]
            return false unless %w[create_file delete_file update_file].include?(safe_string(value[:operation][:type]))
          end

          if type == :additional_tools && Array === value[:tools]
            unless value.fetch(:tools).all? do |tool|
                Hash === tool && supported_union_type?(OpenAI::Responses::Tool, tool[:type])
              end

              return false
            end
          end

          return true unless type == :shell_call_output
          return true unless Array === value[:output]

          value.fetch(:output).all? do |chunk|
            !(Hash === chunk) || valid_shell_outcome_discriminator?(chunk[:outcome])
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
          !(Hash === caller) || %w[direct program].include?(safe_string(caller[:type]))
        end

        def valid_shell_outcome_discriminator?(outcome)
          !(Hash === outcome) || %w[timeout exit].include?(safe_string(outcome[:type]))
        end

        def valid_input_message_metadata?(value)
          return false if value.key?(:id) && !(String === value[:id])
          return true unless value.key?(:status) && !(NilClass === value[:status])

          OpenAI::Responses::ResponseInputMessageItem::Status.values.include?(safe_symbol(value[:status]))
        end

        def valid_tool_output_discriminators?(output)
          return true if String === output
          return true unless Array === output

          output.all? do |item|
            next true unless Hash === item

            case safe_string(item[:type])
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
          [value[:file_id], value[:image_url]].count { |source| String === source } == 1
        end

        def valid_file_source?(value)
          [value[:file_data], value[:file_id], value[:file_url]].count { |source| String === source } == 1
        end

        def valid_annotations?(annotations)
          return false unless Array === annotations

          annotations.all? do |annotation|
            Hash === annotation &&
              %w[file_citation url_citation container_file_citation file_path].include?(safe_string(annotation[:type]))
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
              missing_constant = core_class(normalized).known_fields.any? do |name, field|
                field.fetch(:required) &&
                  field.fetch(:const) &&
                  !value.key?(name) &&
                  !value.key?(field.fetch(:api_name))
              end

              return true if missing_constant
            end

            value.any? do |key, child|
              field_name, field = core_class(normalized).known_fields.find do |known_name, known_field|
                known_name == key || known_field.fetch(:api_name) == key
              end

              next false unless field

              missing_nested_discriminator?(child, normalized.to_h[field_name], nested: true)
            end

          in [Array, Array]
            Array.instance_method(:zip).bind_call(value, normalized).any? do |child, coerced|
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
              name = String === key ? String.instance_method(:to_sym).bind_call(key) : key
              field_name, field = core_class(normalized).known_fields.find do |known_name, known_field|
                known_name == name || known_field.fetch(:api_name) == name
              end

              next 0 unless field
              if NilClass === nested
                next !field.fetch(:required) && !field.fetch(:nilable) ? 1 : 0
              end

              allowed_explicit_nulls(nested, normalized.to_h[field_name])
            end

          in [Array, Array]
            Array
              .instance_method(:zip)
              .bind_call(value, normalized)
              .sum { |nested, coerced| allowed_explicit_nulls(nested, coerced) }
          else
            0
          end
        end

        def default_input_image_details!(value)
          content = input_image_content_list(value)
          return false unless content

          changed = false
          content.each do |item|
            next unless Hash === item && safe_string(item[:type]) == "input_image"
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
            Hash === item &&
              safe_string(item[:type]) == "input_image" &&
              item.key?(:detail) &&
              NilClass === item[:detail]
          end
        end

        def input_image_content_list(value)
          type = safe_string(value[:type])
          return value[:content] if ((NilClass === type) || type == "message") && Array === value[:content]
          return value[:output] if type == "custom_tool_call_output" && Array === value[:output]
        end

        def remove_sdk_parsed!(value)
          type = safe_symbol(value[:type])
          changed = type == :function_call && value.key?(:parsed)
          value.delete(:parsed) if changed

          if type == :message && Array === value[:content]
            value.fetch(:content).each do |content|
              next unless Hash === content
              next unless safe_string(content[:type]) == "output_text" && content.key?(:parsed)

              content.delete(:parsed)
              changed = true
            end
          end

          changed
        end

        def contains_sdk_parsed?(value)
          case value
          in OpenAI::Internal::Type::BaseModel
            found = core_class(value).known_fields.key?(:parsed) && value.to_h.key?(:parsed)
            if OpenAI::Responses::ResponseOutputMessage === value && Array === value.to_h[:content]
              value.to_h.fetch(:content).each do |content|
                content_has_parsed = case content
                in OpenAI::Internal::Type::BaseModel
                  core_class(content).known_fields.key?(:parsed) && content.to_h.key?(:parsed)
                in Hash
                  type = content[:type] || content["type"]
                  safe_string(type) == "output_text" && (content.key?(:parsed) || content.key?("parsed"))
                else
                  false
                end

                found ||= content_has_parsed
              end
            end

            found
          in Hash
            type = safe_symbol(value[:type])
            found = type == :function_call && value.key?(:parsed)
            if type == :message && Array === value[:content]
              value.fetch(:content).each do |content|
                next unless Hash === content

                found ||= safe_string(content[:type]) == "output_text" && content.key?(:parsed)
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
          type = safe_symbol(type)
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
