# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #   A EvalResponsesSource object describing a run data source configuration.
        #
        #   @return [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses]
        required :source, union: -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::Source }

        # @!attribute type
        #   The type of run data source. Always `responses`.
        #
        #   @return [Symbol, OpenAI::Evals::CreateEvalResponsesRunDataSource::Type]
        required :type, enum: -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::Type }

        # @!attribute input_messages
        #
        #   @return [OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference, nil]
        optional :input_messages, union: -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages }

        # @!attribute model
        #   The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute sampling_params
        #
        #   @return [OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams, nil]
        optional :sampling_params, -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams }

        # @!method initialize(source:, type:, input_messages: nil, model: nil, sampling_params: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Evals::CreateEvalResponsesRunDataSource} for more details.
        #
        #   A ResponsesRunDataSource object describing a model sampling configuration.
        #
        #   @param source [OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses] A EvalResponsesSource object describing a run data source configuration.
        #
        #   @param type [Symbol, OpenAI::Evals::CreateEvalResponsesRunDataSource::Type] The type of run data source. Always `responses`.
        #
        #   @param input_messages [OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference]
        #
        #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @param sampling_params [OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams]

        # A EvalResponsesSource object describing a run data source configuration.
        #
        # @see OpenAI::Evals::CreateEvalResponsesRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::EvalJSONLFileContentSource }

          variant :file_id, -> { OpenAI::Evals::EvalJSONLFileIDSource }

          # A EvalResponsesSource object describing a run data source configuration.
          variant :responses, -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses }

          class Responses < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of run data source. Always `responses`.
            #
            #   @return [Symbol, :responses]
            required :type, const: :responses

            # @!attribute created_after
            #   Only include items created after this timestamp (inclusive). This is a query
            #   parameter used to select responses.
            #
            #   @return [Integer, nil]
            optional :created_after, Integer, nil?: true

            # @!attribute created_before
            #   Only include items created before this timestamp (inclusive). This is a query
            #   parameter used to select responses.
            #
            #   @return [Integer, nil]
            optional :created_before, Integer, nil?: true

            # @!attribute has_tool_calls
            #   Whether the response has tool calls. This is a query parameter used to select
            #   responses.
            #
            #   @return [Boolean, nil]
            optional :has_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

            # @!attribute instructions_search
            #   Optional string to search the 'instructions' field. This is a query parameter
            #   used to select responses.
            #
            #   @return [String, nil]
            optional :instructions_search, String, nil?: true

            # @!attribute metadata
            #   Metadata filter for the responses. This is a query parameter used to select
            #   responses.
            #
            #   @return [Object, nil]
            optional :metadata, OpenAI::Internal::Type::Unknown, nil?: true

            # @!attribute model
            #   The name of the model to find responses for. This is a query parameter used to
            #   select responses.
            #
            #   @return [String, nil]
            optional :model, String, nil?: true

            # @!attribute reasoning_effort
            #   Optional reasoning effort parameter. This is a query parameter used to select
            #   responses.
            #
            #   @return [Symbol, OpenAI::ReasoningEffort, nil]
            optional :reasoning_effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

            # @!attribute temperature
            #   Sampling temperature. This is a query parameter used to select responses.
            #
            #   @return [Float, nil]
            optional :temperature, Float, nil?: true

            # @!attribute tools
            #   List of tool names. This is a query parameter used to select responses.
            #
            #   @return [Array<String>, nil]
            optional :tools, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!attribute top_p
            #   Nucleus sampling parameter. This is a query parameter used to select responses.
            #
            #   @return [Float, nil]
            optional :top_p, Float, nil?: true

            # @!attribute users
            #   List of user identifiers. This is a query parameter used to select responses.
            #
            #   @return [Array<String>, nil]
            optional :users, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!method initialize(created_after: nil, created_before: nil, has_tool_calls: nil, instructions_search: nil, metadata: nil, model: nil, reasoning_effort: nil, temperature: nil, tools: nil, top_p: nil, users: nil, type: :responses)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses} for more
            #   details.
            #
            #   A EvalResponsesSource object describing a run data source configuration.
            #
            #   @param created_after [Integer, nil] Only include items created after this timestamp (inclusive). This is a query par
            #
            #   @param created_before [Integer, nil] Only include items created before this timestamp (inclusive). This is a query pa
            #
            #   @param has_tool_calls [Boolean, nil] Whether the response has tool calls. This is a query parameter used to select re
            #
            #   @param instructions_search [String, nil] Optional string to search the 'instructions' field. This is a query parameter us
            #
            #   @param metadata [Object, nil] Metadata filter for the responses. This is a query parameter used to select resp
            #
            #   @param model [String, nil] The name of the model to find responses for. This is a query parameter used to s
            #
            #   @param reasoning_effort [Symbol, OpenAI::ReasoningEffort, nil] Optional reasoning effort parameter. This is a query parameter used to select re
            #
            #   @param temperature [Float, nil] Sampling temperature. This is a query parameter used to select responses.
            #
            #   @param tools [Array<String>, nil] List of tool names. This is a query parameter used to select responses.
            #
            #   @param top_p [Float, nil] Nucleus sampling parameter. This is a query parameter used to select responses.
            #
            #   @param users [Array<String>, nil] List of user identifiers. This is a query parameter used to select responses.
            #
            #   @param type [Symbol, :responses] The type of run data source. Always `responses`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Evals::EvalJSONLFileContentSource, OpenAI::Evals::EvalJSONLFileIDSource, OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource,
                OpenAI::Evals::EvalJSONLFileIDSource,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses
              )
            end
          end
        end

        # The type of run data source. Always `responses`.
        #
        # @see OpenAI::Evals::CreateEvalResponsesRunDataSource#type
        module Type
          extend OpenAI::Internal::Type::Enum

          RESPONSES = :responses

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Evals::CreateEvalResponsesRunDataSource#input_messages
        module InputMessages
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :template, -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template }

          variant :item_reference,
                  -> { OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference }

          class Template < OpenAI::Internal::Type::BaseModel
            # @!attribute template
            #   A list of chat messages forming the prompt or context. May include variable
            #   references to the "item" namespace, ie {{item.name}}.
            #
            #   @return [Array<OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::EvalItem>]
            required :template,
                     -> {
                       OpenAI::Internal::Type::ArrayOf[union: OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template]
                     }

            # @!attribute type
            #   The type of input messages. Always `template`.
            #
            #   @return [Symbol, :template]
            required :type, const: :template

            # @!method initialize(template:, type: :template)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template} for
            #   more details.
            #
            #   @param template [Array<OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
            #
            #   @param type [Symbol, :template] The type of input messages. Always `template`.

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            module Template
              extend OpenAI::Internal::Type::Union

              variant -> {
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage
              }

              # A message input to the model with a role indicating instruction following
              # hierarchy. Instructions given with the `developer` or `system` role take
              # precedence over instructions given with the `user` role. Messages with the
              # `assistant` role are presumed to have been generated by the model in previous
              # interactions.
              variant -> { OpenAI::EvalItem }

              class ChatMessage < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   The content of the message.
                #
                #   @return [String]
                required :content, String

                # @!attribute role
                #   The role of the message (e.g. "system", "assistant", "user").
                #
                #   @return [String]
                required :role, String

                # @!method initialize(content:, role:)
                #   @param content [String] The content of the message.
                #
                #   @param role [String] The role of the message (e.g. "system", "assistant", "user").
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::EvalItem)]

              define_sorbet_constant!(:Variants) do
                T.type_alias do
                  T.any(
                    OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                    OpenAI::EvalItem
                  )
                end
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
          #   @return [Array(OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
              )
            end
          end
        end

        # @see OpenAI::Evals::CreateEvalResponsesRunDataSource#sampling_params
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
