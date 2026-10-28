# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionItemCreateEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionItemCreateEvent,
            OpenAI::Internal::AnyHash
          )
        end

        sig {
          returns(
            T.any(
              OpenAI::Live::DecisionUserMessage,
              OpenAI::Live::DecisionDeveloperMessage,
              OpenAI::Live::DecisionSystemMessage,
              OpenAI::Live::DecisionAssistantMessage,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput
            )
          )
        }
        attr_reader :item

        sig {
          params(
            item: T.any(
              OpenAI::Live::DecisionUserMessage::OrHash,
              OpenAI::Live::DecisionDeveloperMessage::OrHash,
              OpenAI::Live::DecisionSystemMessage::OrHash,
              OpenAI::Live::DecisionAssistantMessage::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::OrHash
            )
          )
            .void
        }
        attr_writer :item

        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Append an input item for future decisions without starting an evaluation or
        # changing Live voice context.
        sig do
          params(

            item: T.any(
              OpenAI::Live::DecisionUserMessage::OrHash,
              OpenAI::Live::DecisionDeveloperMessage::OrHash,
              OpenAI::Live::DecisionSystemMessage::OrHash,
              OpenAI::Live::DecisionAssistantMessage::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::OrHash,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::OrHash
            ),

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          item:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          type: :"decision.item.create"
        )
        end

        sig do
          override.returns(
            {
              item: T.any(
                OpenAI::Live::DecisionUserMessage,
                OpenAI::Live::DecisionDeveloperMessage,
                OpenAI::Live::DecisionSystemMessage,
                OpenAI::Live::DecisionAssistantMessage,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput
              ),
              type: Symbol,
              event_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        module ItemUnion
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::DecisionUserMessage,
              OpenAI::Live::DecisionDeveloperMessage,
              OpenAI::Live::DecisionSystemMessage,
              OpenAI::Live::DecisionAssistantMessage,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall,
              OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput
            )
          }

          class FunctionCall < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall,
                OpenAI::Internal::AnyHash
              )
            end

            # The function arguments as a JSON string.
            sig { returns(String) }
            attr_accessor :arguments

            # The unique ID of the function tool call generated by the model.
            sig { returns(String) }
            attr_accessor :call_id

            sig { returns(String) }
            attr_accessor :name

            # The item type. Always `function_call`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The local Decision item ID.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            # The namespace of the function to call.
            sig { returns(T.nilable(String)) }
            attr_accessor :namespace

            sig {
              returns(T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::OrSymbol))
            }
            attr_accessor :status

            sig do
              params(

                arguments: String,

                call_id: String,

                name: String,

                id: T.nilable(String),

                namespace: T.nilable(String),

                status: T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::OrSymbol),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The function arguments as a JSON string.
              arguments:,

              # The unique ID of the function tool call generated by the model.
              call_id:,

              name:,

              # The local Decision item ID.
              id: nil,

              # The namespace of the function to call.
              namespace: nil,

              status: nil,

              # The item type. Always `function_call`.

              type: :function_call
            )
            end

            sig do
              override.returns(
                {
                  arguments: String,
                  call_id: String,
                  name: String,
                  type: Symbol,
                  id: T.nilable(String),
                  namespace: T.nilable(String),
                  status: T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::OrSymbol)
                }
              )
            end
            def to_hash
            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCall::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

            # The unique ID of the function tool call generated by the model.
            sig { returns(String) }
            attr_accessor :call_id

            # The text input to the model.
            sig { returns(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Variants) }
            attr_accessor :output

            # The type of the function tool call output. Always `function_call_output`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The local Decision item ID.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig {
              returns(T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::OrSymbol))
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                output: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Variants,

                id: T.nilable(String),

                status: T.nilable(
                  OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::OrSymbol
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The unique ID of the function tool call generated by the model.
              call_id:,

              # The text input to the model.
              output:,

              # The local Decision item ID.
              id: nil,

              status: nil,

              # The type of the function tool call output. Always `function_call_output`.

              type: :function_call_output
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  output: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Variants,
                  type: Symbol,
                  id: T.nilable(String),
                  status: T.nilable(
                    OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::OrSymbol
                  )
                }
              )
            end
            def to_hash
            end

            # The text input to the model.
            module Output
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  String,
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::Variants]
                )
              }

              module Part
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias {
                  T.any(
                    OpenAI::Live::DecisionInputText,
                    OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage
                  )
                }

                class InputImage < OpenAI::Internal::Type::BaseModel
                  OrHash = T.type_alias do
                    T.any(
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage,
                      OpenAI::Internal::AnyHash
                    )
                  end

                  # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
                  sig { returns(String) }
                  attr_accessor :image_url

                  sig { returns(Symbol) }
                  attr_accessor :type

                  # The detail level of the image to be sent to the model. One of `high`, `low`,
                  # `auto`, or `original`. Defaults to `auto`.
                  sig {
                    returns(
                      T.nilable(
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::OrSymbol
                      )
                    )
                  }
                  attr_accessor :detail

                  sig do
                    params(

                      image_url: String,

                      detail: T.nilable(
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::OrSymbol
                      ),

                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(

                    # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
                    image_url:,

                    # The detail level of the image to be sent to the model. One of `high`, `low`,
                    # `auto`, or `original`. Defaults to `auto`.
                    detail: nil,

                    type: :input_image
                  )
                  end

                  sig do
                    override.returns(
                      {
                        image_url: String,
                        type: Symbol,
                        detail: T.nilable(
                          OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::OrSymbol
                        )
                      }
                    )
                  end
                  def to_hash
                  end

                  # The detail level of the image to be sent to the model. One of `high`, `low`,
                  # `auto`, or `original`. Defaults to `auto`.
                  module Detail
                    extend OpenAI::Internal::Type::Enum

                    TaggedSymbol = T.type_alias {
                      T.all(
                        Symbol,
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail
                      )
                    }
                    OrSymbol = T.type_alias { T.any(Symbol, String) }

                    LOW = T.let(
                      :low,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    HIGH = T.let(
                      :high,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    AUTO = T.let(
                      :auto,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    ORIGINAL = T.let(
                      :original,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )

                    sig {
                      override.returns(
                        T::Array[
                          OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                        ]
                      )
                    }
                    def self.values
                    end
                  end
                end

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part::Variants
                    ]
                  )
                }
                def self.variants
                end

              end

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Variants]
                )
              }
              def self.variants
              end

              PartsArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Output::Part
                ],
                OpenAI::Internal::Type::Converter
              )

            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::FunctionCallOutput::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class CustomToolCall < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall,
                OpenAI::Internal::AnyHash
              )
            end

            # The unique ID of the function tool call generated by the model.
            sig { returns(String) }
            attr_accessor :call_id

            # The input to the custom tool call.
            sig { returns(String) }
            attr_accessor :input

            # The name of the custom tool to call.
            sig { returns(String) }
            attr_accessor :name

            # The item type. Always `custom_tool_call`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The local Decision item ID.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            # The namespace of the function to call.
            sig { returns(T.nilable(String)) }
            attr_accessor :namespace

            sig {
              returns(T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::OrSymbol))
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                input: String,

                name: String,

                id: T.nilable(String),

                namespace: T.nilable(String),

                status: T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::OrSymbol),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The unique ID of the function tool call generated by the model.
              call_id:,

              # The input to the custom tool call.
              input:,

              # The name of the custom tool to call.
              name:,

              # The local Decision item ID.
              id: nil,

              # The namespace of the function to call.
              namespace: nil,

              status: nil,

              # The item type. Always `custom_tool_call`.

              type: :custom_tool_call
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  input: String,
                  name: String,
                  type: Symbol,
                  id: T.nilable(String),
                  namespace: T.nilable(String),
                  status: T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::OrSymbol)
                }
              )
            end
            def to_hash
            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCall::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class CustomToolCallOutput < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

            # The unique ID of the function tool call generated by the model.
            sig { returns(String) }
            attr_accessor :call_id

            # The text input to the model.
            sig { returns(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Variants) }
            attr_accessor :output

            sig { returns(Symbol) }
            attr_accessor :type

            # The local Decision item ID.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig {
              returns(
                T.nilable(OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::OrSymbol)
              )
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                output: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Variants,

                id: T.nilable(String),

                status: T.nilable(
                  OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::OrSymbol
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The unique ID of the function tool call generated by the model.
              call_id:,

              # The text input to the model.
              output:,

              # The local Decision item ID.
              id: nil,

              status: nil,

              type: :custom_tool_call_output
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  output: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Variants,
                  type: Symbol,
                  id: T.nilable(String),
                  status: T.nilable(
                    OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::OrSymbol
                  )
                }
              )
            end
            def to_hash
            end

            # The text input to the model.
            module Output
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  String,
                  T::Array[
                    OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::Variants
                  ]
                )
              }

              module Part
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias {
                  T.any(
                    OpenAI::Live::DecisionInputText,
                    OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage
                  )
                }

                class InputImage < OpenAI::Internal::Type::BaseModel
                  OrHash = T.type_alias do
                    T.any(
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage,
                      OpenAI::Internal::AnyHash
                    )
                  end

                  # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
                  sig { returns(String) }
                  attr_accessor :image_url

                  sig { returns(Symbol) }
                  attr_accessor :type

                  # The detail level of the image to be sent to the model. One of `high`, `low`,
                  # `auto`, or `original`. Defaults to `auto`.
                  sig {
                    returns(
                      T.nilable(
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::OrSymbol
                      )
                    )
                  }
                  attr_accessor :detail

                  sig do
                    params(

                      image_url: String,

                      detail: T.nilable(
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::OrSymbol
                      ),

                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(

                    # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
                    image_url:,

                    # The detail level of the image to be sent to the model. One of `high`, `low`,
                    # `auto`, or `original`. Defaults to `auto`.
                    detail: nil,

                    type: :input_image
                  )
                  end

                  sig do
                    override.returns(
                      {
                        image_url: String,
                        type: Symbol,
                        detail: T.nilable(
                          OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::OrSymbol
                        )
                      }
                    )
                  end
                  def to_hash
                  end

                  # The detail level of the image to be sent to the model. One of `high`, `low`,
                  # `auto`, or `original`. Defaults to `auto`.
                  module Detail
                    extend OpenAI::Internal::Type::Enum

                    TaggedSymbol = T.type_alias {
                      T.all(
                        Symbol,
                        OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail
                      )
                    }
                    OrSymbol = T.type_alias { T.any(Symbol, String) }

                    LOW = T.let(
                      :low,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    HIGH = T.let(
                      :high,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    AUTO = T.let(
                      :auto,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )
                    ORIGINAL = T.let(
                      :original,
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                    )

                    sig {
                      override.returns(
                        T::Array[
                          OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::InputImage::Detail::TaggedSymbol
                        ]
                      )
                    }
                    def self.values
                    end
                  end
                end

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part::Variants
                    ]
                  )
                }
                def self.variants
                end

              end

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Variants]
                )
              }
              def self.variants
              end

              PartsArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Output::Part
                ],
                OpenAI::Internal::Type::Converter
              )

            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::CustomToolCallOutput::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreateEvent::ItemUnion::Variants]) }
          def self.variants
          end

        end

        Item = ::OpenAI::Models::Live::DecisionUserMessage
      end

    end

  end
end
