# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @abstract
      class BaseModel
        extend OpenAI::Internal::Type::Converter
        extend OpenAI::Internal::Util::SorbetRuntimeSupport

        class << self
          # @api private
          #
          # Assumes superclass fields are totally defined before fields are accessed /
          # defined on subclasses.
          #
          # @param child [Class<OpenAI::Internal::Type::BaseModel>]
          def inherited(child)
            super
            child.known_fields.replace(known_fields.dup)
          end

          # @api private
          #
          # @return [Hash{Symbol=>Hash{Symbol=>Object}}]
          def known_fields = @known_fields ||= {}

          # @api private
          #
          # @return [Hash{Symbol=>Hash{Symbol=>Object}}]
          def fields
            known_fields.transform_values do |field|
              {**field.except(:type_fn), type: field.fetch(:type_fn).call}
            end
          end

          # @api private
          #
          # @param name_sym [Symbol]
          #
          # @param required [Boolean]
          #
          # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class]
          #
          # @param spec [Hash{Symbol=>Object}] .
          #
          #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
          #
          #   @option spec [Proc] :enum
          #
          #   @option spec [Proc] :union
          #
          #   @option spec [Boolean] :"nil?"
          private def add_field(name_sym, required:, type_info:, spec:)
            meta = OpenAI::Internal::Type::Converter.meta_info(type_info, spec)
            type_fn, info =
              case type_info
              in Proc | OpenAI::Internal::Type::Converter | Class
                [OpenAI::Internal::Type::Converter.type_info({**spec, union: type_info}), spec]
              in Hash
                [OpenAI::Internal::Type::Converter.type_info(type_info), type_info]
              end

            setter = :"#{name_sym}="
            api_name = info.fetch(:api_name, name_sym)
            nilable = info.fetch(:nil?, false)
            const = required && !nilable ? info.fetch(:const, OpenAI::Internal::OMIT) : OpenAI::Internal::OMIT

            [name_sym, setter].each { undef_method(_1) } if known_fields.key?(name_sym)

            known_fields[name_sym] =
              {
                mode: @mode,
                api_name: api_name,
                required: required,
                nilable: nilable,
                const: const,
                type_fn: type_fn,
                meta: meta
              }

            define_method(setter) do |value|
              target = type_fn.call
              state = OpenAI::Internal::Type::Converter.new_coerce_state(translate_names: false)
              coerced = OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
              status = @coerced.store(name_sym, state.fetch(:error) || true)
              stored =
                case [target, status]
                in [OpenAI::Internal::Type::Converter | Symbol, true]
                  coerced
                else
                  value
                end
              @data.store(name_sym, stored)
            end

            # rubocop:disable Style/CaseEquality
            # rubocop:disable Metrics/BlockLength
            define_method(name_sym) do
              target = type_fn.call

              case @coerced[name_sym]
              in true | false if OpenAI::Internal::Type::Converter === target
                @data.fetch(name_sym)
              in ::StandardError => e
                raise OpenAI::Errors::ConversionError.new(
                  on: self.class,
                  method: __method__,
                  target: target,
                  value: @data.fetch(name_sym),
                  cause: e
                )
              else
                Kernel.then do
                  value = @data.fetch(name_sym) { const == OpenAI::Internal::OMIT ? nil : const }
                  state = OpenAI::Internal::Type::Converter.new_coerce_state(translate_names: false)
                  if (nilable || !required) && value.nil?
                    nil
                  else
                    OpenAI::Internal::Type::Converter.coerce(
                      target, value, state: state
                    )
                  end
                rescue StandardError => e
                  raise OpenAI::Errors::ConversionError.new(
                    on: self.class,
                    method: __method__,
                    target: target,
                    value: value,
                    cause: e
                  )
                end
              end
            end
            # rubocop:enable Metrics/BlockLength
            # rubocop:enable Style/CaseEquality
          end

          # @api private
          #
          # @param name_sym [Symbol]
          #
          # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class]
          #
          # @param spec [Hash{Symbol=>Object}] .
          #
          #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
          #
          #   @option spec [Proc] :enum
          #
          #   @option spec [Proc] :union
          #
          #   @option spec [Boolean] :"nil?"
          def required(name_sym, type_info, spec = {})
            add_field(name_sym, required: true, type_info: type_info, spec: spec)
          end

          # @api private
          #
          # @param name_sym [Symbol]
          #
          # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class]
          #
          # @param spec [Hash{Symbol=>Object}] .
          #
          #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
          #
          #   @option spec [Proc] :enum
          #
          #   @option spec [Proc] :union
          #
          #   @option spec [Boolean] :"nil?"
          def optional(name_sym, type_info, spec = {})
            add_field(name_sym, required: false, type_info: type_info, spec: spec)
          end

          # @api private
          #
          # `request_only` attributes not excluded from `.#coerce` when receiving responses
          # even if well behaved servers should not send them
          #
          # @param blk [Proc]
          private def request_only(&blk)
            @mode = :dump
            blk.call
          ensure
            @mode = nil
          end

          # @api private
          #
          # `response_only` attributes are omitted from `.#dump` when making requests
          #
          # @param blk [Proc]
          private def response_only(&blk)
            @mode = :coerce
            blk.call
          ensure
            @mode = nil
          end

          # @api public
          #
          # @param other [Object]
          #
          # @return [Boolean]
          def ==(other)
            other.is_a?(Class) && other <= OpenAI::Internal::Type::BaseModel && other.fields == fields
          end

          # @api public
          #
          # @return [Integer]
          def hash = fields.hash
        end

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def ==(other) = self.class == other.class && @data == other.to_h

        # @api public
        #
        # @return [Integer]
        def hash = [self.class, @data].hash

        class << self
          # @api private
          #
          # @param value [OpenAI::Internal::Type::BaseModel, Hash{Object=>Object}, Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :translate_names
          #
          #   @option state [Boolean] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Class<StandardError>] :error
          #
          #   @option state [Integer] :branched
          #
          # @return [self, Object]
          def coerce(value, state:)
            exactness = state.fetch(:exactness)

            if value.is_a?(self)
              exactness[:yes] += 1
              return value
            end

            unless (val = OpenAI::Internal::Util.coerce_hash(value)).is_a?(Hash)
              exactness[:no] += 1
              state[:error] = TypeError.new("#{value.class} can't be coerced into #{Hash}")
              return value
            end
            exactness[:yes] += 1

            keys = val.keys.to_set
            instance = new
            data = instance.to_h
            status = instance.instance_variable_get(:@coerced)

            # rubocop:disable Metrics/BlockLength
            fields.each do |name, field|
              mode, required, target = field.fetch_values(:mode, :required, :type)
              api_name, nilable, const = field.fetch_values(:api_name, :nilable, :const)
              src_name = state.fetch(:translate_names) ? api_name : name

              unless val.key?(src_name)
                if required && mode != :dump && const == OpenAI::Internal::OMIT
                  exactness[nilable ? :maybe : :no] += 1
                else
                  exactness[:yes] += 1
                end
                next
              end

              item = val.fetch(src_name)
              keys.delete(src_name)

              state[:error] = nil
              converted =
                if item.nil? && (nilable || !required)
                  exactness[nilable ? :yes : :maybe] += 1
                  nil
                else
                  coerced = OpenAI::Internal::Type::Converter.coerce(target, item, state: state)
                  case target
                  in OpenAI::Internal::Type::Converter | Symbol
                    coerced
                  else
                    item
                  end
                end

              status.store(name, state.fetch(:error) || true)
              data.store(name, converted)
            end
            # rubocop:enable Metrics/BlockLength

            keys.each { data.store(_1, val.fetch(_1)) }
            instance
          end

          # @api private
          #
          # @param value [self, Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :can_retry
          #
          # @return [Hash{Object=>Object}, Object]
          def dump(value, state:)
            unless (coerced = OpenAI::Internal::Util.coerce_hash(value)).is_a?(Hash)
              return super
            end

            acc = {}

            coerced.each do |key, val|
              name = key.is_a?(String) ? key.to_sym : key
              case (field = known_fields[name])
              in nil
                acc.store(name, super(val, state: state))
              else
                api_name, mode, type_fn = field.fetch_values(:api_name, :mode, :type_fn)
                case mode
                in :coerce
                  next
                else
                  target = type_fn.call
                  acc.store(api_name, OpenAI::Internal::Type::Converter.dump(target, val, state: state))
                end
              end
            end

            known_fields.each_value do |field|
              api_name, mode, const = field.fetch_values(:api_name, :mode, :const)
              next if mode == :coerce || acc.key?(api_name) || const == OpenAI::Internal::OMIT
              acc.store(api_name, const)
            end

            acc
          end

          # @api private
          #
          # @return [Object]
          def to_sorbet_type
            self
          end
        end

        class << self
          # @api private
          #
          # @param model [OpenAI::Internal::Type::BaseModel]
          # @param convert [Boolean]
          #
          # @return [Hash{Symbol=>Object}]
          def recursively_to_h(model, convert:)
            rec = ->(x) do
              case x
              in OpenAI::Internal::Type::BaseModel
                if convert
                  fields = x.class.known_fields
                  x.to_h.to_h do |key, val|
                    [key, rec.call(fields.key?(key) ? x.public_send(key) : val)]
                  rescue OpenAI::Errors::ConversionError
                    [key, rec.call(val)]
                  end
                else
                  rec.call(x.to_h)
                end
              in Hash
                x.transform_values(&rec)
              in Array
                x.map(&rec)
              else
                x
              end
            end
            rec.call(model)
          end
        end

        # @api public
        #
        # Returns the raw value associated with the given key, if found. Otherwise, nil is
        # returned.
        #
        # It is valid to lookup keys that are not in the API spec, for example to access
        # undocumented features. This method does not parse response data into
        # higher-level types. Lookup by anything other than a Symbol is an ArgumentError.
        #
        # @param key [Symbol]
        #
        # @return [Object, nil]
        def [](key)
          unless key.instance_of?(Symbol)
            raise ArgumentError.new("Expected symbol key for lookup, got #{key.inspect}")
          end

          @data[key]
        end

        # @api public
        #
        # Returns a Hash of the data underlying this object. O(1)
        #
        # Keys are Symbols and values are the raw values from the response. The return
        # value indicates which values were ever set on the object. i.e. there will be a
        # key in this hash if they ever were, even if the set value was nil.
        #
        # This method is not recursive. The returned value is shared by the object, so it
        # should not be mutated.
        #
        # @return [Hash{Symbol=>Object}]
        def to_h = @data

        alias_method :to_hash, :to_h

        # @api public
        #
        # In addition to the behaviour of `#to_h`, this method will recursively call
        # `#to_h` on nested models.
        #
        # @return [Hash{Symbol=>Object}]
        def deep_to_h = self.class.recursively_to_h(@data, convert: false)

        # @param keys [Array<Symbol>, nil]
        #
        # @return [Hash{Symbol=>Object}]
        #
        # @example
        #   # `comparison_filter` is a `OpenAI::ComparisonFilter`
        #   comparison_filter => {
        #     key: key,
        #     type: type,
        #     value: value
        #   }
        def deconstruct_keys(keys)
          (keys || self.class.known_fields.keys)
            .filter_map do |k|
              unless self.class.known_fields.key?(k)
                next
              end

              [k, public_send(k)]
            end
            .to_h
        end

        # @api public
        #
        # @param a [Object]
        #
        # @return [String]
        def to_json(*a) = OpenAI::Internal::Type::Converter.dump(self.class, self).to_json(*a)

        # @api public
        #
        # @param a [Object]
        #
        # @return [String]
        def to_yaml(*a) = OpenAI::Internal::Type::Converter.dump(self.class, self).to_yaml(*a)

        # Create a new instance of a model.
        #
        # @param data [Hash{Symbol=>Object}, self]
        def initialize(data = {})
          @data = {}
          @coerced = {}
          OpenAI::Internal::Util.coerce_hash!(data).each do
            if self.class.known_fields.key?(_1)
              public_send(:"#{_1}=", _2)
            else
              @data.store(_1, _2)
              @coerced.store(_1, false)
            end
          end
        end

        class << self
          # @api private
          #
          # @param depth [Integer]
          #
          # @return [String]
          def inspect(depth: 0)
            return super() if depth.positive?

            depth = depth.succ
            deferred = fields.transform_values do |field|
              type, required, nilable = field.fetch_values(:type, :required, :nilable)
              inspected = [
                OpenAI::Internal::Type::Converter.inspect(type, depth: depth),
                !required || nilable ? "nil" : nil
              ].compact.join(" | ")
              -> { inspected }.tap { _1.define_singleton_method(:inspect) { call } }
            end

            "#{name}[#{deferred.inspect}]"
          end
        end

        # @api public
        #
        # @return [String]
        def to_s = deep_to_h.to_s

        # @api private
        #
        # @return [String]
        def inspect
          converted = self.class.recursively_to_h(self, convert: true)
          "#<#{self.class}:0x#{object_id.to_s(16)} #{converted}>"
        end

        define_sorbet_constant!(:KnownField) do
          T.type_alias { {mode: T.nilable(Symbol), required: T::Boolean, nilable: T::Boolean} }
        end
      end
    end
  end
end
