# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #   Determines what populates the `item` namespace in this run's data source.
        #
        #   @return [OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
        required :source, union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source }

        # @!attribute type
        #   The type of run data source. Always `completions`.
        #
        #   @return [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type]
        required :type, enum: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type }

        # @!attribute input_messages
        #   Used when sampling from a model. Dictates the structure of the messages passed
        #   into the model. Can either be a reference to a prebuilt trajectory (ie,
        #   `item.input_trajectory`), or a template with variable references to the `item`
        #   namespace.
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
        #   @param source [OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions] Determines what populates the `item` namespace in this run's data source.
        #
        #   @param type [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type] The type of run data source. Always `completions`.
        #
        #   @param input_messages [OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference] Used when sampling from a model. Dictates the structure of the messages passed i
        #
        #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @param sampling_params [OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams]

        # Determines what populates the `item` namespace in this run's data source.
        #
        # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent }

          variant :file_id, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID }

          # A StoredCompletionsRunDataSource configuration describing a set of filters
          variant :stored_completions,
                  -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions }

          class FileContent < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the jsonl file.
            #
            #   @return [Array<OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>]
            required :content,
                     -> {
                       OpenAI::Internal::Type::ArrayOf[OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content]
                     }

            # @!attribute type
            #   The type of jsonl source. Always `file_content`.
            #
            #   @return [Symbol, :file_content]
            required :type, const: :file_content

            # @!method initialize(content:, type: :file_content)
            #   @param content [Array<OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>] The content of the jsonl file.
            #
            #   @param type [Symbol, :file_content] The type of jsonl source. Always `file_content`.

            class Content < OpenAI::Internal::Type::BaseModel
              # @!attribute item
              #
              #   @return [Hash{Symbol=>Object}]
              required :item, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

              # @!attribute sample
              #
              #   @return [Hash{Symbol=>Object}, nil]
              optional :sample, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

              # @!method initialize(item:, sample: nil)
              #   @param item [Hash{Symbol=>Object}]
              #   @param sample [Hash{Symbol=>Object}]
            end
          end

          class FileID < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the file.
            #
            #   @return [String]
            required :id, String

            # @!attribute type
            #   The type of jsonl source. Always `file_id`.
            #
            #   @return [Symbol, :file_id]
            required :type, const: :file_id

            # @!method initialize(id:, type: :file_id)
            #   @param id [String] The identifier of the file.
            #
            #   @param type [Symbol, :file_id] The type of jsonl source. Always `file_id`.
          end

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
          #   @return [Array(OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
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

        # Used when sampling from a model. Dictates the structure of the messages passed
        # into the model. Can either be a reference to a prebuilt trajectory (ie,
        # `item.input_trajectory`), or a template with variable references to the `item`
        # namespace.
        #
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
            #   references to the `item` namespace, ie {{item.name}}.
            #
            #   @return [Array<OpenAI::Responses::EasyInputMessage, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message>]
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
            #   @param template [Array<OpenAI::Responses::EasyInputMessage, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message>] A list of chat messages forming the prompt or context. May include variable refe
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
              variant :message,
                      -> {
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message
                      }

              class Message < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   Text inputs to the model - can contain template strings.
                #
                #   @return [String, OpenAI::Responses::ResponseInputText, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText]
                required :content,
                         union: -> {
                           OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content
                         }

                # @!attribute role
                #   The role of the message input. One of `user`, `assistant`, `system`, or
                #   `developer`.
                #
                #   @return [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Role]
                required :role,
                         enum: -> {
                           OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Role
                         }

                # @!attribute type
                #   The type of the message input. Always `message`.
                #
                #   @return [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Type, nil]
                optional :type,
                         enum: -> {
                           OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Type
                         }

                # @!method initialize(content:, role:, type: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message}
                #   for more details.
                #
                #   A message input to the model with a role indicating instruction following
                #   hierarchy. Instructions given with the `developer` or `system` role take
                #   precedence over instructions given with the `user` role. Messages with the
                #   `assistant` role are presumed to have been generated by the model in previous
                #   interactions.
                #
                #   @param content [String, OpenAI::Responses::ResponseInputText, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText] Text inputs to the model - can contain template strings.
                #
                #   @param role [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Role] The role of the message input. One of `user`, `assistant`, `system`, or
                #
                #   @param type [Symbol, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Type] The type of the message input. Always `message`.

                # Text inputs to the model - can contain template strings.
                #
                # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message#content
                module Content
                  extend OpenAI::Internal::Type::Union

                  # A text input to the model.
                  variant String

                  # A text input to the model.
                  variant -> { OpenAI::Responses::ResponseInputText }

                  # A text output from the model.
                  variant -> {
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText
                  }

                  class OutputText < OpenAI::Internal::Type::BaseModel
                    # @!attribute text
                    #   The text output from the model.
                    #
                    #   @return [String]
                    required :text, String

                    # @!attribute type
                    #   The type of the output text. Always `output_text`.
                    #
                    #   @return [Symbol, :output_text]
                    required :type, const: :output_text

                    # @!method initialize(text:, type: :output_text)
                    #   Some parameter documentations has been truncated, see
                    #   {OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText}
                    #   for more details.
                    #
                    #   A text output from the model.
                    #
                    #   @param text [String] The text output from the model.
                    #
                    #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`.
                  end

                  # @!method self.variants
                  #   @return [Array(String, OpenAI::Responses::ResponseInputText, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText)]

                  define_sorbet_constant!(:Variants) do
                    T.type_alias do
                      T.any(
                        String,
                        OpenAI::Responses::ResponseInputText,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message::Content::OutputText
                      )
                    end
                  end
                end

                # The role of the message input. One of `user`, `assistant`, `system`, or
                # `developer`.
                #
                # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message#role
                module Role
                  extend OpenAI::Internal::Type::Enum

                  USER = :user
                  ASSISTANT = :assistant
                  SYSTEM = :system
                  DEVELOPER = :developer

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # The type of the message input. Always `message`.
                #
                # @see OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  MESSAGE = :message

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Responses::EasyInputMessage, OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message)]

              define_sorbet_constant!(:Variants) do
                T.type_alias do
                  T.any(
                    OpenAI::Responses::EasyInputMessage,
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Message
                  )
                end
              end
            end
          end

          class ItemReference < OpenAI::Internal::Type::BaseModel
            # @!attribute item_reference
            #   A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
            #
            #   @return [String]
            required :item_reference, String

            # @!attribute type
            #   The type of input messages. Always `item_reference`.
            #
            #   @return [Symbol, :item_reference]
            required :type, const: :item_reference

            # @!method initialize(item_reference:, type: :item_reference)
            #   @param item_reference [String] A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
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
