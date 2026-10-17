# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Decisions#create
    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   The text or images to evaluate for every question. Provide a text string or user
      #   messages containing text and images. Images can be base64 data URLs or publicly
      #   accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      #   one request. Files, audio, tools, and item references are not supported.
      #
      #   @return [String, Array<OpenAI::Models::DecisionInputMessage>]
      required :input, union: -> { OpenAI::DecisionCreateParams::Input }

      # @!attribute model
      #   The model to use. Only `gpt-6-luna` is supported.
      #
      #   @return [String]
      required :model, String

      # @!attribute questions
      #   Ask 1–200 questions about the input. Each question can be a predicate, choice,
      #   or score. Answers come back in the same order.
      #
      #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      required :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionCreateParams::Question] }

      # @!attribute prompt_cache_key
      #   Partition prompt cache reuse by caller-provided key.
      #
      #   @return [String, nil]
      optional :prompt_cache_key, String, nil?: true

      # @!attribute prompt_cache_options
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      #   @return [OpenAI::Models::DecisionCreateParams::PromptCacheOptions, nil]
      optional :prompt_cache_options, -> { OpenAI::DecisionCreateParams::PromptCacheOptions }, nil?: true

      # @!attribute safety_identifier
      #   Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #   Responses' limit; this is never the authenticated user identity.
      #
      #   @return [String, nil]
      optional :safety_identifier, String, nil?: true

      # @!method initialize(input:, model:, questions:, prompt_cache_key: nil, prompt_cache_options: nil, safety_identifier: nil, request_options: {})
      #   @param input [String, Array<OpenAI::Models::DecisionInputMessage>]
      #     The text or images to evaluate for every question. Provide a text string or user
      #     messages containing text and images. Images can be base64 data URLs or publicly
      #     accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      #     one request. Files, audio, tools, and item references are not supported.
      #
      #   @param model [String]
      #     The model to use. Only `gpt-6-luna` is supported.
      #
      #   @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      #     Ask 1–200 questions about the input. Each question can be a predicate, choice,
      #     or score. Answers come back in the same order.
      #
      #   @param prompt_cache_key [String, nil]
      #     Partition prompt cache reuse by caller-provided key.
      #
      #   @param prompt_cache_options [OpenAI::Models::DecisionCreateParams::PromptCacheOptions, nil]
      #     Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #     default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #     explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #     request can write up to four breakpoints. For cache matching, OpenAI considers
      #     up to the latest 80 breakpoints in the conversation, without a content-block
      #     lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #     `ttl` defaults to `30m`, which is currently the only supported value. See the
      #     [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #     for current details.
      #
      #   @param safety_identifier [String, nil]
      #     Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #     Responses' limit; this is never the authenticated user identity.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The text or images to evaluate for every question. Provide a text string or user
      # messages containing text and images. Images can be base64 data URLs or publicly
      # accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      # one request. Files, audio, tools, and item references are not supported.
      module Input
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::DecisionCreateParams::Input::DecisionInputMessageArray }

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::DecisionInputMessage>)]

        # @type [OpenAI::Internal::Type::Converter]
        DecisionInputMessageArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputMessage }]
      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Estimate how likely it is that a statement about the input is true.
        variant :predicate, -> { OpenAI::DecisionCreateParams::Question::Predicate }

        # Choose from the supplied options based on the input.
        variant :choice, -> { OpenAI::DecisionCreateParams::Question::Choice }

        # Rate the input against the supplied ordered levels.
        variant :score, -> { OpenAI::DecisionCreateParams::Question::Score }

        class Predicate < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #
          #   @return [String]
          required :instructions, String

          # @!attribute type
          #   The type of the object. Always `predicate`.
          #
          #   @return [Symbol, :predicate]
          required :type, const: :predicate

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, name: nil, type: :predicate)
          #   Estimate how likely it is that a statement about the input is true.
          #
          #   @param instructions [String]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :predicate]
          #     The type of the object. Always `predicate`.
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute choices
          #   Provide between 2 and 255 choices. Each choice must be unique.
          #
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
          required(
            :choices,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Choice::Choice] }
          )

          # @!attribute instructions
          #
          #   @return [String]
          required :instructions, String

          # @!attribute type
          #   The type of the object. Always `choice`.
          #
          #   @return [Symbol, :choice]
          required :type, const: :choice

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(choices:, instructions:, name: nil, type: :choice)
          #   Choose from the supplied options based on the input.
          #
          #   @param choices [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
          #     Provide between 2 and 255 choices. Each choice must be unique.
          #
          #   @param instructions [String]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :choice]
          #     The type of the object. Always `choice`.
          class Choice < OpenAI::Internal::Type::BaseModel
            # @!attribute value
            #   Choice values are typed: a string and a boolean with the same text are distinct.
            #
            #   @return [String, Boolean]
            required :value, union: -> { OpenAI::DecisionCreateParams::Question::Choice::Choice::Value }

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String

            # @!method initialize(value:, description: nil)
            #   @param value [String, Boolean]
            #     Choice values are typed: a string and a boolean with the same text are distinct.
            #
            #   @param description [String]

            # Choice values are typed: a string and a boolean with the same text are distinct.
            #
            # @see OpenAI::Models::DecisionCreateParams::Question::Choice::Choice#value
            module Value
              extend OpenAI::Internal::Type::Union

              variant String

              variant OpenAI::Internal::Type::Boolean

              # @!method self.variants
              #   @return [Array(String, Boolean)]
            end
          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #
          #   @return [String]
          required :instructions, String

          # @!attribute levels
          #
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
          required(
            :levels,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Score::Level] }
          )

          # @!attribute type
          #   The type of the object. Always `score`.
          #
          #   @return [Symbol, :score]
          required :type, const: :score

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, levels:, name: nil, type: :score)
          #   Rate the input against the supplied ordered levels.
          #
          #   @param instructions [String]
          #
          #   @param levels [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :score]
          #     The type of the object. Always `score`.
          class Level < OpenAI::Internal::Type::BaseModel
            # @!attribute label
            #
            #   @return [String]
            required :label, String

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String

            # @!method initialize(label:, description: nil)
            #   @param label [String]
            #   @param description [String]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score)]
      end

      class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
        # @!attribute mode
        #   Controls whether OpenAI automatically creates an implicit cache breakpoint.
        #   Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        #   and writes up to the latest three explicit breakpoints in the request. With
        #   `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        #   latest four explicit breakpoints. If there are no explicit breakpoints, the
        #   request does not use prompt caching.
        #
        #   @return [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Mode, nil]
        optional :mode, enum: -> { OpenAI::DecisionCreateParams::PromptCacheOptions::Mode }, nil?: true

        # @!attribute ttl
        #   The minimum lifetime applied to every implicit and explicit cache breakpoint
        #   written by the request. Defaults to `30m`, which is currently the only supported
        #   value. The backend may retain cache entries for longer.
        #
        #   @return [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Ttl, nil]
        optional :ttl, enum: -> { OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl }

        # @!method initialize(mode: nil, ttl: nil)
        #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
        #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        #   request can write up to four breakpoints. For cache matching, OpenAI considers
        #   up to the latest 80 breakpoints in the conversation, without a content-block
        #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        #   `ttl` defaults to `30m`, which is currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        #   @param mode [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Mode, nil]
        #     Controls whether OpenAI automatically creates an implicit cache breakpoint.
        #     Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        #     and writes up to the latest three explicit breakpoints in the request. With
        #     `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        #     latest four explicit breakpoints. If there are no explicit breakpoints, the
        #     request does not use prompt caching.
        #
        #   @param ttl [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Ttl]
        #     The minimum lifetime applied to every implicit and explicit cache breakpoint
        #     written by the request. Defaults to `30m`, which is currently the only supported
        #     value. The backend may retain cache entries for longer.

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        #
        # @see OpenAI::Models::DecisionCreateParams::PromptCacheOptions#mode
        module Mode
          extend OpenAI::Internal::Type::Enum

          IMPLICIT = :implicit
          EXPLICIT = :explicit

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        #
        # @see OpenAI::Models::DecisionCreateParams::PromptCacheOptions#ttl
        module Ttl
          extend OpenAI::Internal::Type::Enum

          TTL_30M = :"30m"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
