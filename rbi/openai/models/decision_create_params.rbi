# typed: strong

module OpenAI
  module Models

    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionCreateParams,
          OpenAI::Internal::AnyHash
        )
      end

      # The text or images to evaluate for every question. Provide a text string or user
      # messages containing text and images. Images can be base64 data URLs or publicly
      # accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      # one request. Files, audio, tools, and item references are not supported.
      sig { returns(OpenAI::DecisionCreateParams::Input::Variants) }
      attr_accessor :input

      # The model to use. Only `gpt-6-luna` is supported.
      sig { returns(String) }
      attr_accessor :model

      # Ask 1–200 questions about the input. Each question can be a predicate, choice,
      # or score. Answers come back in the same order.
      sig {
        returns(
          T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::DecisionCreateParams::Question::Score
            )
          ]
        )
      }
      attr_accessor :questions

      # Partition prompt cache reuse by caller-provided key.
      sig { returns(T.nilable(String)) }
      attr_accessor :prompt_cache_key

      # Options for prompt caching. Supported for `gpt-5.6` and later models. By
      # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      # request can write up to four breakpoints. For cache matching, OpenAI considers
      # up to the latest 80 breakpoints in the conversation, without a content-block
      # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      # `ttl` defaults to `30m`, which is currently the only supported value. See the
      # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      # for current details.
      sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash)) }
      attr_accessor :prompt_cache_options

      # Opaque caller-provided end-user identifier, scoped by the verified org. Match
      # Responses' limit; this is never the authenticated user identity.
      sig { returns(T.nilable(String)) }
      attr_accessor :safety_identifier

      sig do
        params(

          input: OpenAI::DecisionCreateParams::Input::Variants,

          model: String,

          questions: T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate::OrHash,
              OpenAI::DecisionCreateParams::Question::Choice::OrHash,
              OpenAI::DecisionCreateParams::Question::Score::OrHash
            )
          ],

          prompt_cache_key: T.nilable(String),

          prompt_cache_options: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash),

          safety_identifier: T.nilable(String),

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The text or images to evaluate for every question. Provide a text string or user
        # messages containing text and images. Images can be base64 data URLs or publicly
        # accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
        # one request. Files, audio, tools, and item references are not supported.
        input:,

        # The model to use. Only `gpt-6-luna` is supported.
        model:,

        # Ask 1–200 questions about the input. Each question can be a predicate, choice,
        # or score. Answers come back in the same order.
        questions:,

        # Partition prompt cache reuse by caller-provided key.
        prompt_cache_key: nil,

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        # for current details.
        prompt_cache_options: nil,

        # Opaque caller-provided end-user identifier, scoped by the verified org. Match
        # Responses' limit; this is never the authenticated user identity.
        safety_identifier: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            input: OpenAI::DecisionCreateParams::Input::Variants,
            model: String,
            questions: T::Array[
              T.any(
                OpenAI::DecisionCreateParams::Question::Predicate,
                OpenAI::DecisionCreateParams::Question::Choice,
                OpenAI::DecisionCreateParams::Question::Score
              )
            ],
            prompt_cache_key: T.nilable(String),
            prompt_cache_options: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash),
            safety_identifier: T.nilable(String),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The text or images to evaluate for every question. Provide a text string or user
      # messages containing text and images. Images can be base64 data URLs or publicly
      # accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      # one request. Files, audio, tools, and item references are not supported.
      module Input
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputMessage]) }

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Input::Variants]) }
        def self.variants
        end

        DecisionInputMessageArray = T.let(
          OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputMessage],
          OpenAI::Internal::Type::Converter
        )

      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::DecisionCreateParams::Question::Predicate,
            OpenAI::DecisionCreateParams::Question::Choice,
            OpenAI::DecisionCreateParams::Question::Score
          )
        }

        class Predicate < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :instructions

          # The type of the object. Always `predicate`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Estimate how likely it is that a statement about the input is true.
          sig do
            params(

              instructions: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            name: nil,

            # The type of the object. Always `predicate`.

            type: :predicate
          )
          end

          sig do
            override.returns(
              {instructions: String, type: Symbol, name: String}
            )
          end
          def to_hash
          end

        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::Internal::AnyHash
            )
          end

          # Provide between 2 and 255 choices. Each choice must be unique.
          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice]) }
          attr_accessor :choices

          sig { returns(String) }
          attr_accessor :instructions

          # The type of the object. Always `choice`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Choose from the supplied options based on the input.
          sig do
            params(

              choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::OrHash],

              instructions: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Provide between 2 and 255 choices. Each choice must be unique.
            choices:,

            instructions:,

            name: nil,

            # The type of the object. Always `choice`.

            type: :choice
          )
          end

          sig do
            override.returns(
              {
                choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice],
                instructions: String,
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          class Choice < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Choice::Choice,
                OpenAI::Internal::AnyHash
              )
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            sig { returns(T.any(String, T::Boolean)) }
            attr_accessor :value

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                value: T.any(String, T::Boolean),

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Choice values are typed: a string and a boolean with the same text are distinct.
              value:,

              description: nil
            )
            end

            sig do
              override.returns(
                {value: T.any(String, T::Boolean), description: String}
              )
            end
            def to_hash
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            module Value
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Boolean) }

              sig {
                override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::Value::Variants])
              }
              def self.variants
              end

            end
          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Score,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :instructions

          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Score::Level]) }
          attr_accessor :levels

          # The type of the object. Always `score`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Rate the input against the supplied ordered levels.
          sig do
            params(

              instructions: String,

              levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level::OrHash],

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            levels:,

            name: nil,

            # The type of the object. Always `score`.

            type: :score
          )
          end

          sig do
            override.returns(
              {
                instructions: String,
                levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level],
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          class Level < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Score::Level,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :label

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                label: String,

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              label:,

              description: nil
            )
            end

            sig do
              override.returns(
                {label: String, description: String}
              )
            end
            def to_hash
            end

          end
        end

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Variants]) }
        def self.variants
        end

      end

      class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionCreateParams::PromptCacheOptions,
            OpenAI::Internal::AnyHash
          )
        end

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol)) }
        attr_accessor :mode

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol)) }
        attr_reader :ttl

        sig { params(ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol).void }
        attr_writer :ttl

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        # for current details.
        sig do
          params(

            mode: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol),

            ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          mode: nil,

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.

          ttl: nil
        )
        end

        sig do
          override.returns(
            {
              mode: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol),
              ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol
            }
          )
        end
        def to_hash
        end

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        module Mode
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IMPLICIT = T.let(:implicit, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol)
          EXPLICIT = T.let(:explicit, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol]) }
          def self.values
          end
        end

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        module Ttl
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TTL_30M = T.let(:"30m", OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::TaggedSymbol]) }
          def self.values
          end
        end
      end

    end

  end
end
