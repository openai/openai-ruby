# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute input_messages
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference]
        required :input_messages,
                 union: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages }

        # @!attribute model
        #   The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @return [String]
        required :model, String

        # @!attribute source
        #   A StoredCompletionsRunDataSource configuration describing a set of filters
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
        required :source, union: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source }

        # @!attribute type
        #   The type of run data source. Always `completions`.
        #
        #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type]
        required :type, enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type }

        # @!attribute sampling_params
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams, nil]
        optional :sampling_params,
                 -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams }

        # @!method initialize(input_messages:, model:, source:, type:, sampling_params: nil)
        #   A CompletionsRunDataSource object describing a model sampling configuration.
        #
        #   @param input_messages [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference]
        #   @param model [String]
        #   @param source [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
        #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type]
        #   @param sampling_params [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams]

        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#input_messages
        module InputMessages
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :template,
                  -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template }

          variant :item_reference,
                  -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference }

          class Template < OpenAI::Internal::Type::BaseModel
            # @!attribute template
            #   A list of chat messages forming the prompt or context. May include variable
            #   references to the "item" namespace, ie {{item.name}}.
            #
            #   @return [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage>]
            required :template,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template] }

            # @!attribute type
            #   The type of input messages. Always `template`.
            #
            #   @return [Symbol, :template]
            required :type, const: :template

            # @!method initialize(template:, type: :template)
            #   @param template [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage>]
            #   @param type [Symbol, :template]

            module Template
              extend OpenAI::Internal::Type::Union

              variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage }

              variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage }

              variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage }

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
                #   @param content [String]
                #   @param role [String]
              end

              class InputMessage < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #
                #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content]
                required :content,
                         -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content }

                # @!attribute role
                #   The role of the message. One of `user`, `system`, or `developer`.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role]
                required :role,
                         enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role }

                # @!attribute type
                #   The type of item, which is always `message`.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type]
                required :type,
                         enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type }

                # @!method initialize(content:, role:, type:)
                #   @param content [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content]
                #   @param role [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role]
                #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type]

                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage#content
                class Content < OpenAI::Internal::Type::BaseModel
                  # @!attribute text
                  #   The text content.
                  #
                  #   @return [String]
                  required :text, String

                  # @!attribute type
                  #   The type of content, which is always `input_text`.
                  #
                  #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type]
                  required :type,
                           enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type }

                  # @!method initialize(text:, type:)
                  #   @param text [String]
                  #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type]

                  # The type of content, which is always `input_text`.
                  #
                  # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content#type
                  module Type
                    extend OpenAI::Internal::Type::Enum

                    INPUT_TEXT = :input_text

                    # @!method self.values
                    #   @return [Array<Symbol>]
                  end
                end

                # The role of the message. One of `user`, `system`, or `developer`.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage#role
                module Role
                  extend OpenAI::Internal::Type::Enum

                  USER = :user
                  SYSTEM = :system
                  DEVELOPER = :developer

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # The type of item, which is always `message`.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  MESSAGE = :message

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              class OutputMessage < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #
                #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content]
                required :content,
                         -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content }

                # @!attribute role
                #   The role of the message. Must be `assistant` for output.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role]
                required :role,
                         enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role }

                # @!attribute type
                #   The type of item, which is always `message`.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type]
                required :type,
                         enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type }

                # @!method initialize(content:, role:, type:)
                #   @param content [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content]
                #   @param role [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role]
                #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type]

                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage#content
                class Content < OpenAI::Internal::Type::BaseModel
                  # @!attribute text
                  #   The text content.
                  #
                  #   @return [String]
                  required :text, String

                  # @!attribute type
                  #   The type of content, which is always `output_text`.
                  #
                  #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type]
                  required :type,
                           enum: -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type }

                  # @!method initialize(text:, type:)
                  #   @param text [String]
                  #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type]

                  # The type of content, which is always `output_text`.
                  #
                  # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content#type
                  module Type
                    extend OpenAI::Internal::Type::Enum

                    OUTPUT_TEXT = :output_text

                    # @!method self.values
                    #   @return [Array<Symbol>]
                  end
                end

                # The role of the message. Must be `assistant` for output.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage#role
                module Role
                  extend OpenAI::Internal::Type::Enum

                  ASSISTANT = :assistant

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # The type of item, which is always `message`.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  MESSAGE = :message

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage)]
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
            #   @param item_reference [String]
            #   @param type [Symbol, :item_reference]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference)]
        end

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        #
        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content,
                  -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent }

          variant :file_id, -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID }

          # A StoredCompletionsRunDataSource configuration describing a set of filters
          variant :stored_completions,
                  -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions }

          class FileContent < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the jsonl file.
            #
            #   @return [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content] }

            # @!attribute type
            #   The type of jsonl source. Always `file_content`.
            #
            #   @return [Symbol, :file_content]
            required :type, const: :file_content

            # @!method initialize(content:, type: :file_content)
            #   @param content [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>]
            #   @param type [Symbol, :file_content]

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
            #   @param id [String]
            #   @param type [Symbol, :file_id]
          end

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            # @!attribute created_after
            #   An optional Unix timestamp to filter items created after this time.
            #
            #   @return [Integer, nil]
            required :created_after, Integer, nil?: true

            # @!attribute created_before
            #   An optional Unix timestamp to filter items created before this time.
            #
            #   @return [Integer, nil]
            required :created_before, Integer, nil?: true

            # @!attribute limit
            #   An optional maximum number of items to return.
            #
            #   @return [Integer, nil]
            required :limit, Integer, nil?: true

            # @!attribute metadata
            #   Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            #
            #   @return [Hash{Symbol=>String}, nil]
            required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute model
            #   An optional model to filter by (e.g., 'gpt-4o').
            #
            #   @return [String, nil]
            required :model, String, nil?: true

            # @!attribute type
            #   The type of source. Always `stored_completions`.
            #
            #   @return [Symbol, :stored_completions]
            required :type, const: :stored_completions

            # @!method initialize(created_after:, created_before:, limit:, metadata:, model:, type: :stored_completions)
            #   A StoredCompletionsRunDataSource configuration describing a set of filters
            #
            #   @param created_after [Integer, nil]
            #   @param created_before [Integer, nil]
            #   @param limit [Integer, nil]
            #   @param metadata [Hash{Symbol=>String}, nil]
            #   @param model [String, nil]
            #   @param type [Symbol, :stored_completions]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions)]
        end

        # The type of run data source. Always `completions`.
        #
        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPLETIONS = :completions

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#sampling_params
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
          #   @param max_completion_tokens [Integer]
          #   @param seed [Integer]
          #   @param temperature [Float]
          #   @param top_p [Float]
        end
      end
    end
  end
end
