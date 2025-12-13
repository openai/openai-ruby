# typed: strong

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Internal::AnyHash
            )
          end

        # Determines what populates the `item` namespace in this run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
            )
          )
        end
        attr_accessor :source

        # The type of run data source. Always `completions`.
        sig do
          returns(
            OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol
          )
        end
        attr_accessor :type

        # Used when sampling from a model. Dictates the structure of the messages passed
        # into the model. Can either be a reference to a prebuilt trajectory (ie,
        # `item.input_trajectory`), or a template with variable references to the `item`
        # namespace.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
              )
            )
          )
        end
        attr_reader :input_messages

        sig do
          params(
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference::OrHash
              )
          ).void
        end
        attr_writer :input_messages

        # The name of the model to use for generating completions (e.g. "o3-mini").
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        sig do
          returns(
            T.nilable(
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams
            )
          )
        end
        attr_reader :sampling_params

        sig do
          params(
            sampling_params:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::OrHash
          ).void
        end
        attr_writer :sampling_params

        # A CompletionsRunDataSource object describing a model sampling configuration.
        sig do
          params(
            source:
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions::OrHash
              ),
            type:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference::OrHash
              ),
            model: String,
            sampling_params:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Determines what populates the `item` namespace in this run's data source.
          source:,
          # The type of run data source. Always `completions`.
          type:,
          # Used when sampling from a model. Dictates the structure of the messages passed
          # into the model. Can either be a reference to a prebuilt trajectory (ie,
          # `item.input_trajectory`), or a template with variable references to the `item`
          # namespace.
          input_messages: nil,
          # The name of the model to use for generating completions (e.g. "o3-mini").
          model: nil,
          sampling_params: nil
        )
        end

        sig do
          override.returns(
            {
              source:
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
                ),
              type:
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
              input_messages:
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
                ),
              model: String,
              sampling_params:
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams
            }
          )
        end
        def to_hash
        end

        # Determines what populates the `item` namespace in this run's data source.
        module Source
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
              )
            end

          class FileContent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The content of the jsonl file.
            sig do
              returns(
                T::Array[
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content
                ]
              )
            end
            attr_accessor :content

            # The type of jsonl source. Always `file_content`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                content:
                  T::Array[
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The content of the jsonl file.
              content:,
              # The type of jsonl source. Always `file_content`.
              type: :file_content
            )
            end

            sig do
              override.returns(
                {
                  content:
                    T::Array[
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class Content < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(T::Hash[Symbol, T.anything]) }
              attr_accessor :item

              sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
              attr_reader :sample

              sig { params(sample: T::Hash[Symbol, T.anything]).void }
              attr_writer :sample

              sig do
                params(
                  item: T::Hash[Symbol, T.anything],
                  sample: T::Hash[Symbol, T.anything]
                ).returns(T.attached_class)
              end
              def self.new(item:, sample: nil)
              end

              sig do
                override.returns(
                  {
                    item: T::Hash[Symbol, T.anything],
                    sample: T::Hash[Symbol, T.anything]
                  }
                )
              end
              def to_hash
              end
            end
          end

          class FileID < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier of the file.
            sig { returns(String) }
            attr_accessor :id

            # The type of jsonl source. Always `file_id`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { params(id: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The identifier of the file.
              id:,
              # The type of jsonl source. Always `file_id`.
              type: :file_id
            )
            end

            sig { override.returns({ id: String, type: Symbol }) }
            def to_hash
            end
          end

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions,
                  OpenAI::Internal::AnyHash
                )
              end

            # The type of source. Always `stored_completions`.
            sig { returns(Symbol) }
            attr_accessor :type

            # An optional Unix timestamp to filter items created after this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_after

            # An optional Unix timestamp to filter items created before this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_before

            # An optional maximum number of items to return.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # An optional model to filter by (e.g., 'gpt-4o').
            sig { returns(T.nilable(String)) }
            attr_accessor :model

            # A StoredCompletionsRunDataSource configuration describing a set of filters
            sig do
              params(
                created_after: T.nilable(Integer),
                created_before: T.nilable(Integer),
                limit: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.nilable(String),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # An optional Unix timestamp to filter items created after this time.
              created_after: nil,
              # An optional Unix timestamp to filter items created before this time.
              created_before: nil,
              # An optional maximum number of items to return.
              limit: nil,
              # Set of 16 key-value pairs that can be attached to an object. This can be useful
              # for storing additional information about the object in a structured format, and
              # querying for objects via API or the dashboard.
              #
              # Keys are strings with a maximum length of 64 characters. Values are strings with
              # a maximum length of 512 characters.
              metadata: nil,
              # An optional model to filter by (e.g., 'gpt-4o').
              model: nil,
              # The type of source. Always `stored_completions`.
              type: :stored_completions
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  created_after: T.nilable(Integer),
                  created_before: T.nilable(Integer),
                  limit: T.nilable(Integer),
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  model: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The type of run data source. Always `completions`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETIONS =
            T.let(
              :completions,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # Used when sampling from a model. Dictates the structure of the messages passed
        # into the model. Can either be a reference to a prebuilt trajectory (ie,
        # `item.input_trajectory`), or a template with variable references to the `item`
        # namespace.
        module InputMessages
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
              )
            end

          class Template < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of chat messages forming the prompt or context. May include variable
            # references to the `item` namespace, ie {{item.name}}.
            sig do
              returns(
                T::Array[
                  T.any(
                    OpenAI::Responses::EasyInputMessage,
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem
                  )
                ]
              )
            end
            attr_accessor :template

            # The type of input messages. Always `template`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                template:
                  T::Array[
                    T.any(
                      OpenAI::Responses::EasyInputMessage::OrHash,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::OrHash
                    )
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # A list of chat messages forming the prompt or context. May include variable
              # references to the `item` namespace, ie {{item.name}}.
              template:,
              # The type of input messages. Always `template`.
              type: :template
            )
            end

            sig do
              override.returns(
                {
                  template:
                    T::Array[
                      T.any(
                        OpenAI::Responses::EasyInputMessage,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem
                      )
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            module Template
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::EasyInputMessage,
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem
                  )
                end

              class EvalItem < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Inputs to the model - can contain template strings. Supports text, output text,
                # input images, and input audio, either as a single item or an array of items.
                sig do
                  returns(
                    T.any(
                      String,
                      OpenAI::Responses::ResponseInputText,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::EvalItemInputImage,
                      OpenAI::Responses::ResponseInputAudio,
                      T::Array[
                        T.any(
                          String,
                          OpenAI::Responses::ResponseInputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::OutputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::EvalItemInputImage,
                          OpenAI::Responses::ResponseInputAudio
                        )
                      ]
                    )
                  )
                end
                attr_accessor :content

                # The role of the message input. One of `user`, `assistant`, `system`, or
                # `developer`.
                sig do
                  returns(
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol
                  )
                end
                attr_accessor :role

                # The type of the message input. Always `message`.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                    )
                  )
                end
                attr_reader :type

                sig do
                  params(
                    type:
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                  ).void
                end
                attr_writer :type

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                sig do
                  params(
                    content:
                      T.any(
                        String,
                        OpenAI::Responses::ResponseInputText::OrHash,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText::OrHash,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::EvalItemInputImage::OrHash,
                        OpenAI::Responses::ResponseInputAudio::OrHash,
                        T::Array[
                          T.any(
                            String,
                            OpenAI::Responses::ResponseInputText::OrHash,
                            OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::OutputText::OrHash,
                            OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::EvalItemInputImage::OrHash,
                            OpenAI::Responses::ResponseInputAudio::OrHash
                          )
                        ]
                      ),
                    role:
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                    type:
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Inputs to the model - can contain template strings. Supports text, output text,
                  # input images, and input audio, either as a single item or an array of items.
                  content:,
                  # The role of the message input. One of `user`, `assistant`, `system`, or
                  # `developer`.
                  role:,
                  # The type of the message input. Always `message`.
                  type: nil
                )
                end

                sig do
                  override.returns(
                    {
                      content:
                        T.any(
                          String,
                          OpenAI::Responses::ResponseInputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::EvalItemInputImage,
                          OpenAI::Responses::ResponseInputAudio,
                          T::Array[
                            T.any(
                              String,
                              OpenAI::Responses::ResponseInputText,
                              OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::OutputText,
                              OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::EvalItemInputImage,
                              OpenAI::Responses::ResponseInputAudio
                            )
                          ]
                        ),
                      role:
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                      type:
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                    }
                  )
                end
                def to_hash
                end

                # Inputs to the model - can contain template strings. Supports text, output text,
                # input images, and input audio, either as a single item or an array of items.
                module Content
                  extend OpenAI::Internal::Type::Union

                  Variants =
                    T.type_alias do
                      T.any(
                        String,
                        OpenAI::Responses::ResponseInputText,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::EvalItemInputImage,
                        OpenAI::Responses::ResponseInputAudio,
                        T::Array[
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::Variants
                        ]
                      )
                    end

                  class OutputText < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # The text output from the model.
                    sig { returns(String) }
                    attr_accessor :text

                    # The type of the output text. Always `output_text`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    # A text output from the model.
                    sig do
                      params(text: String, type: Symbol).returns(
                        T.attached_class
                      )
                    end
                    def self.new(
                      # The text output from the model.
                      text:,
                      # The type of the output text. Always `output_text`.
                      type: :output_text
                    )
                    end

                    sig { override.returns({ text: String, type: Symbol }) }
                    def to_hash
                    end
                  end

                  class EvalItemInputImage < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::EvalItemInputImage,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # The URL of the image input.
                    sig { returns(String) }
                    attr_accessor :image_url

                    # The type of the image input. Always `input_image`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    # The detail level of the image to be sent to the model. One of `high`, `low`, or
                    # `auto`. Defaults to `auto`.
                    sig { returns(T.nilable(String)) }
                    attr_reader :detail

                    sig { params(detail: String).void }
                    attr_writer :detail

                    # An image input block used within EvalItem content arrays.
                    sig do
                      params(
                        image_url: String,
                        detail: String,
                        type: Symbol
                      ).returns(T.attached_class)
                    end
                    def self.new(
                      # The URL of the image input.
                      image_url:,
                      # The detail level of the image to be sent to the model. One of `high`, `low`, or
                      # `auto`. Defaults to `auto`.
                      detail: nil,
                      # The type of the image input. Always `input_image`.
                      type: :input_image
                    )
                    end

                    sig do
                      override.returns(
                        { image_url: String, type: Symbol, detail: String }
                      )
                    end
                    def to_hash
                    end
                  end

                  # A text input to the model.
                  module AnArrayOfInputTextOutputTextInputImageAndInputAudio
                    extend OpenAI::Internal::Type::Union

                    Variants =
                      T.type_alias do
                        T.any(
                          String,
                          OpenAI::Responses::ResponseInputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::OutputText,
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::EvalItemInputImage,
                          OpenAI::Responses::ResponseInputAudio
                        )
                      end

                    class OutputText < OpenAI::Internal::Type::BaseModel
                      OrHash =
                        T.type_alias do
                          T.any(
                            OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::OutputText,
                            OpenAI::Internal::AnyHash
                          )
                        end

                      # The text output from the model.
                      sig { returns(String) }
                      attr_accessor :text

                      # The type of the output text. Always `output_text`.
                      sig { returns(Symbol) }
                      attr_accessor :type

                      # A text output from the model.
                      sig do
                        params(text: String, type: Symbol).returns(
                          T.attached_class
                        )
                      end
                      def self.new(
                        # The text output from the model.
                        text:,
                        # The type of the output text. Always `output_text`.
                        type: :output_text
                      )
                      end

                      sig { override.returns({ text: String, type: Symbol }) }
                      def to_hash
                      end
                    end

                    class EvalItemInputImage < OpenAI::Internal::Type::BaseModel
                      OrHash =
                        T.type_alias do
                          T.any(
                            OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::EvalItemInputImage,
                            OpenAI::Internal::AnyHash
                          )
                        end

                      # The URL of the image input.
                      sig { returns(String) }
                      attr_accessor :image_url

                      # The type of the image input. Always `input_image`.
                      sig { returns(Symbol) }
                      attr_accessor :type

                      # The detail level of the image to be sent to the model. One of `high`, `low`, or
                      # `auto`. Defaults to `auto`.
                      sig { returns(T.nilable(String)) }
                      attr_reader :detail

                      sig { params(detail: String).void }
                      attr_writer :detail

                      # An image input block used within EvalItem content arrays.
                      sig do
                        params(
                          image_url: String,
                          detail: String,
                          type: Symbol
                        ).returns(T.attached_class)
                      end
                      def self.new(
                        # The URL of the image input.
                        image_url:,
                        # The detail level of the image to be sent to the model. One of `high`, `low`, or
                        # `auto`. Defaults to `auto`.
                        detail: nil,
                        # The type of the image input. Always `input_image`.
                        type: :input_image
                      )
                      end

                      sig do
                        override.returns(
                          { image_url: String, type: Symbol, detail: String }
                        )
                      end
                      def to_hash
                      end
                    end

                    sig do
                      override.returns(
                        T::Array[
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio::Variants
                        ]
                      )
                    end
                    def self.variants
                    end
                  end

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::Variants
                      ]
                    )
                  end
                  def self.variants
                  end

                  AnArrayOfInputTextOutputTextInputImageAndInputAudioArray =
                    T.let(
                      OpenAI::Internal::Type::ArrayOf[
                        union:
                          OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextOutputTextInputImageAndInputAudio
                      ],
                      OpenAI::Internal::Type::Converter
                    )
                end

                # The role of the message input. One of `user`, `assistant`, `system`, or
                # `developer`.
                module Role
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  USER =
                    T.let(
                      :user,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                    )
                  ASSISTANT =
                    T.let(
                      :assistant,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                    )
                  SYSTEM =
                    T.let(
                      :system,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                    )
                  DEVELOPER =
                    T.let(
                      :developer,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end

                # The type of the message input. Always `message`.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  MESSAGE =
                    T.let(
                      :message,
                      OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end

          class ItemReference < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference,
                  OpenAI::Internal::AnyHash
                )
              end

            # A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
            sig { returns(String) }
            attr_accessor :item_reference

            # The type of input messages. Always `item_reference`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(item_reference: String, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
              item_reference:,
              # The type of input messages. Always `item_reference`.
              type: :item_reference
            )
            end

            sig { override.returns({ item_reference: String, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class SamplingParams < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The maximum number of tokens in the generated output.
          sig { returns(T.nilable(Integer)) }
          attr_reader :max_completion_tokens

          sig { params(max_completion_tokens: Integer).void }
          attr_writer :max_completion_tokens

          # Constrains effort on reasoning for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
          # Reducing reasoning effort can result in faster responses and fewer tokens used
          # on reasoning in a response.
          #
          # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
          #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
          #   calls are supported for all reasoning values in gpt-5.1.
          # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
          #   support `none`.
          # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
          # - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
          sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
          attr_accessor :reasoning_effort

          # An object specifying the format that the model must output.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          # ensures the message the model generates is valid JSON. Using `json_schema` is
          # preferred for models that support it.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::ResponseFormatText,
                  OpenAI::ResponseFormatJSONSchema,
                  OpenAI::ResponseFormatJSONObject
                )
              )
            )
          end
          attr_reader :response_format

          sig do
            params(
              response_format:
                T.any(
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash
                )
            ).void
          end
          attr_writer :response_format

          # A seed value to initialize the randomness, during sampling.
          sig { returns(T.nilable(Integer)) }
          attr_reader :seed

          sig { params(seed: Integer).void }
          attr_writer :seed

          # A higher temperature increases randomness in the outputs.
          sig { returns(T.nilable(Float)) }
          attr_reader :temperature

          sig { params(temperature: Float).void }
          attr_writer :temperature

          # A list of tools the model may call. Currently, only functions are supported as a
          # tool. Use this to provide a list of functions the model may generate JSON inputs
          # for. A max of 128 functions are supported.
          sig do
            returns(
              T.nilable(T::Array[OpenAI::Chat::ChatCompletionFunctionTool])
            )
          end
          attr_reader :tools

          sig do
            params(
              tools: T::Array[OpenAI::Chat::ChatCompletionFunctionTool::OrHash]
            ).void
          end
          attr_writer :tools

          # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
          sig { returns(T.nilable(Float)) }
          attr_reader :top_p

          sig { params(top_p: Float).void }
          attr_writer :top_p

          sig do
            params(
              max_completion_tokens: Integer,
              reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
              response_format:
                T.any(
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash
                ),
              seed: Integer,
              temperature: Float,
              tools: T::Array[OpenAI::Chat::ChatCompletionFunctionTool::OrHash],
              top_p: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The maximum number of tokens in the generated output.
            max_completion_tokens: nil,
            # Constrains effort on reasoning for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
            # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
            # Reducing reasoning effort can result in faster responses and fewer tokens used
            # on reasoning in a response.
            #
            # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
            #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
            #   calls are supported for all reasoning values in gpt-5.1.
            # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
            #   support `none`.
            # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
            # - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
            reasoning_effort: nil,
            # An object specifying the format that the model must output.
            #
            # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
            # Outputs which ensures the model will match your supplied JSON schema. Learn more
            # in the
            # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
            #
            # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
            # ensures the message the model generates is valid JSON. Using `json_schema` is
            # preferred for models that support it.
            response_format: nil,
            # A seed value to initialize the randomness, during sampling.
            seed: nil,
            # A higher temperature increases randomness in the outputs.
            temperature: nil,
            # A list of tools the model may call. Currently, only functions are supported as a
            # tool. Use this to provide a list of functions the model may generate JSON inputs
            # for. A max of 128 functions are supported.
            tools: nil,
            # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
            top_p: nil
          )
          end

          sig do
            override.returns(
              {
                max_completion_tokens: Integer,
                reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                response_format:
                  T.any(
                    OpenAI::ResponseFormatText,
                    OpenAI::ResponseFormatJSONSchema,
                    OpenAI::ResponseFormatJSONObject
                  ),
                seed: Integer,
                temperature: Float,
                tools: T::Array[OpenAI::Chat::ChatCompletionFunctionTool],
                top_p: Float
              }
            )
          end
          def to_hash
          end

          # An object specifying the format that the model must output.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          # ensures the message the model generates is valid JSON. Using `json_schema` is
          # preferred for models that support it.
          module ResponseFormat
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::ResponseFormatText,
                  OpenAI::ResponseFormatJSONSchema,
                  OpenAI::ResponseFormatJSONObject
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::ResponseFormat::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
