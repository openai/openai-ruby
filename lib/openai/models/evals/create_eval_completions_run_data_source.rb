# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #   A StoredCompletionsRunDataSource configuration describing a set of filters
        #
        #   @return [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
        required :source, union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source }

        # @!attribute type
        #   The type of run data source. Always `completions`.
        #
        #   @return [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type]
        required :type, enum: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type }

        # @!attribute input_messages
        #
        #   @return [OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference, nil]
        optional :input_messages,
                 union: -> {
                   OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages
                 }

        # @!attribute model
        #   The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute sampling_params
        #
        #   @return [OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams, nil]
        optional :sampling_params, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams }

        # @!method initialize(source:, type:, input_messages: nil, model: nil, sampling_params: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Evals::CreateEvalCompletionsRunDataSource} for more details.
        #
        #   A CompletionsRunDataSource object describing a model sampling configuration.
        #
        #   @param source [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions] A StoredCompletionsRunDataSource configuration describing a set of filters
        #
        #   @param type [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type] The type of run data source. Always `completions`.
        #
        #   @param input_messages [OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference]
        #
        #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @param sampling_params [OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams]

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        #
        # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::EvalJSONLFileContentSource }

          variant :file_id, -> { OpenAI::Evals::EvalJSONLFileIDSource }

          # A StoredCompletionsRunDataSource configuration describing a set of filters
          variant :stored_completions,
                  -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions }

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of source. Always `stored_completions`.
            #
            #   @return [Symbol, :stored_completions]
            required :type, const: :stored_completions

            # @!attribute created_after
            #   An optional Unix timestamp to filter items created after this time.
            #
            #   @return [Integer, nil]
            optional :created_after, Integer, nil?: true

            # @!attribute created_before
            #   An optional Unix timestamp to filter items created before this time.
            #
            #   @return [Integer, nil]
            optional :created_before, Integer, nil?: true

            # @!attribute limit
            #   An optional maximum number of items to return.
            #
            #   @return [Integer, nil]
            optional :limit, Integer, nil?: true

            # @!attribute metadata
            #   Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute model
            #   An optional model to filter by (e.g., 'gpt-4o').
            #
            #   @return [String, nil]
            optional :model, String, nil?: true

            # @!method initialize(created_after: nil, created_before: nil, limit: nil, metadata: nil, model: nil, type: :stored_completions)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions}
            #   for more details.
            #
            #   A StoredCompletionsRunDataSource configuration describing a set of filters
            #
            #   @param created_after [Integer, nil] An optional Unix timestamp to filter items created after this time.
            #
            #   @param created_before [Integer, nil] An optional Unix timestamp to filter items created before this time.
            #
            #   @param limit [Integer, nil] An optional maximum number of items to return.
            #
            #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
            #
            #   @param model [String, nil] An optional model to filter by (e.g., 'gpt-4o').
            #
            #   @param type [Symbol, :stored_completions] The type of source. Always `stored_completions`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource,
                OpenAI::Evals::EvalJSONLFileIDSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
              )
            end
          end
        end

        # The type of run data source. Always `completions`.
        #
        # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPLETIONS = :completions

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource#input_messages
        module InputMessages
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :template, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template }

          variant :item_reference,
                  -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference }

          class Template < OpenAI::Internal::Type::BaseModel
            # @!attribute template
            #   A list of chat messages forming the prompt or context. May include variable
            #   references to the "item" namespace, ie {{item.name}}.
            #
            #   @return [Array<OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem>]
            required :template,
                     -> {
                       OpenAI::Internal::Type::ArrayOf[union: OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template]
                     }

            # @!attribute type
            #   The type of input messages. Always `template`.
            #
            #   @return [Symbol, :template]
            required :type, const: :template

            # @!method initialize(template:, type: :template)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template} for
            #   more details.
            #
            #   @param template [Array<OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
            #
            #   @param type [Symbol, :template] The type of input messages. Always `template`.

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            module Template
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # A message input to the model with a role indicating instruction following
              # hierarchy. Instructions given with the `developer` or `system` role take
              # precedence over instructions given with the `user` role. Messages with the
              # `assistant` role are presumed to have been generated by the model in previous
              # interactions.
              variant :message, -> { OpenAI::Responses::EasyInputMessage }

              # A message input to the model with a role indicating instruction following
              # hierarchy. Instructions given with the `developer` or `system` role take
              # precedence over instructions given with the `user` role. Messages with the
              # `assistant` role are presumed to have been generated by the model in previous
              # interactions.
              variant :message, -> { OpenAI::EvalItem }

              # @!method self.variants
              #   @return [Array(OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem) }
              end
            end
          end

          class ItemReference < OpenAI::Internal::Type::BaseModel
            # @!attribute item_reference
            #   A reference to a variable in the "item" namespace. Ie, "item.name"
            #
            #   @return [String]
            required :item_reference, String

            # @!attribute type
            #   The type of input messages. Always `item_reference`.
            #
            #   @return [Symbol, :item_reference]
            required :type, const: :item_reference

            # @!method initialize(item_reference:, type: :item_reference)
            #   @param item_reference [String] A reference to a variable in the "item" namespace. Ie, "item.name"
            #
            #   @param type [Symbol, :item_reference] The type of input messages. Always `item_reference`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
              )
            end
          end
        end

        # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource#sampling_params
        class SamplingParams < OpenAI::Internal::Type::BaseModel
          # @!attribute max_completion_tokens
          #   The maximum number of tokens in the generated output.
          #
          #   @return [Integer, nil]
          optional :max_completion_tokens, Integer

          # @!attribute seed
          #   A seed value to initialize the randomness, during sampling.
          #
          #   @return [Integer, nil]
          optional :seed, Integer

          # @!attribute temperature
          #   A higher temperature increases randomness in the outputs.
          #
          #   @return [Float, nil]
          optional :temperature, Float

          # @!attribute top_p
          #   An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
          #
          #   @return [Float, nil]
          optional :top_p, Float

          # @!method initialize(max_completion_tokens: nil, seed: nil, temperature: nil, top_p: nil)
          #   @param max_completion_tokens [Integer] The maximum number of tokens in the generated output.
          #
          #   @param seed [Integer] A seed value to initialize the randomness, during sampling.
          #
          #   @param temperature [Float] A higher temperature increases randomness in the outputs.
          #
          #   @param top_p [Float] An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
        end
      end
    end
  end
end
