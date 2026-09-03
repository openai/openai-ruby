# typed: strong

module OpenAI
  module Models

    module Responses

      # Input to queue for a continuation of the response. Uses the same string or
      # input-item shape as `response.create.input`, with a non-empty array when
      # supplying input items.
      #
      # Steering accepts only messages with the `user` role. Each message may contain
      # only `type`, `role`, and `content`, with `content` as a string or an array of
      # `input_text`, `input_image`, and `input_file` parts. The optional `type` must be
      # `message`. Other roles, tool outputs, and item types are not supported for
      # steering.
      module ResponseSteerInput
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            String,
            T::Array[OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Variants]
          )
        end

        # The output of a function tool call.
        module ResponseSteerInputItemList
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message,
              OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput
            )
          }

          class Message < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message,
                OpenAI::Internal::AnyHash
              )
            end

            # The message content, as an array of content parts.
            sig {
              returns(OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message::Content::Variants)
            }
            attr_accessor :content

            # The message role. Always `user`.
            sig { returns(Symbol) }
            attr_accessor :role

            # The item type. Always `message`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The unique ID of this message item.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            # The status of the message item.
            sig { returns(T.nilable(String)) }
            attr_accessor :status

            sig do
              params(

                content: OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message::Content::Variants,

                id: T.nilable(String),

                status: T.nilable(String),

                role: Symbol,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The message content, as an array of content parts.
              content:,

              # The unique ID of this message item.
              id: nil,

              # The status of the message item.
              status: nil,

              # The message role. Always `user`.
              role: :user,

              # The item type. Always `message`.

              type: :message
            )
            end

            sig do
              override.returns(
                {
                  content: OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message::Content::Variants,
                  role: Symbol,
                  type: Symbol,
                  id: T.nilable(String),
                  status: T.nilable(String)
                }
              )
            end
            def to_hash
            end

            # The message content, as an array of content parts.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(T::Array[OpenAI::Responses::ResponseSteerInputContent::Variants], String)
              }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Message::Content::Variants
                  ]
                )
              }
              def self.variants
              end

              ResponseSteerInputContentArray = T.let(
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseSteerInputContent],
                OpenAI::Internal::Type::Converter
              )

            end
          end

          class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

            # Text, image, or file output of the function tool call.
            sig {
              returns(
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Output::Variants
              )
            }
            attr_accessor :output

            # The type of the function tool call output. Always `function_call_output`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The unique ID of the function tool call output. Populated when this item is
            # returned via API.
            sig { returns(T.nilable(String)) }
            attr_accessor :id

            # The unique ID of the function tool call generated by the model.
            sig { returns(T.nilable(String)) }
            attr_accessor :call_id

            # The execution context that produced this tool call.
            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct,
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program
                  )
                )
              )
            }
            attr_accessor :caller_

            # The name of the tool that produced the output.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # The namespace of the tool that produced the output.
            sig { returns(T.nilable(String)) }
            attr_accessor :namespace

            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            # Populated when items are returned via API.
            sig {
              returns(
                T.nilable(
                  OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::OrSymbol
                )
              )
            }
            attr_accessor :status

            # The output of a function tool call.
            sig do
              params(

                output: OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Output::Variants,

                id: T.nilable(String),

                call_id: T.nilable(String),

                caller_: T.nilable(
                  T.any(
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct::OrHash,
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program::OrHash
                  )
                ),

                name: T.nilable(String),

                namespace: T.nilable(String),

                status: T.nilable(
                  OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::OrSymbol
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Text, image, or file output of the function tool call.
              output:,

              # The unique ID of the function tool call output. Populated when this item is
              # returned via API.
              id: nil,

              # The unique ID of the function tool call generated by the model.
              call_id: nil,

              # The execution context that produced this tool call.
              caller_: nil,

              # The name of the tool that produced the output.
              name: nil,

              # The namespace of the tool that produced the output.
              namespace: nil,

              # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
              # Populated when items are returned via API.
              status: nil,

              # The type of the function tool call output. Always `function_call_output`.

              type: :function_call_output
            )
            end

            sig do
              override.returns(
                {
                  output: OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Output::Variants,
                  type: Symbol,
                  id: T.nilable(String),
                  call_id: T.nilable(String),
                  caller_: T.nilable(
                    T.any(
                      OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct,
                      OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program
                    )
                  ),
                  name: T.nilable(String),
                  namespace: T.nilable(String),
                  status: T.nilable(
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::OrSymbol
                  )
                }
              )
            end
            def to_hash
            end

            # Text, image, or file output of the function tool call.
            module Output
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(String, T::Array[OpenAI::Responses::ResponseFunctionCallOutputItem::Variants])
              }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Output::Variants
                  ]
                )
              }
              def self.variants
              end

            end

            # The execution context that produced this tool call.
            module Caller
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct,
                  OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program
                )
              }

              class Direct < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The caller type. Always `direct`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The caller type. Always `direct`.

                  type: :direct
                )
                end

                sig do
                  override.returns(
                    {type: Symbol}
                  )
                end
                def to_hash
                end

              end

              class Program < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The call ID of the program item that produced this tool call.
                sig { returns(String) }
                attr_accessor :caller_id

                # The caller type. Always `program`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    caller_id: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The call ID of the program item that produced this tool call.
                  caller_id:,

                  # The caller type. Always `program`.

                  type: :program
                )
                end

                sig do
                  override.returns(
                    {caller_id: String, type: Symbol}
                  )
                end
                def to_hash
                end

              end

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Variants
                  ]
                )
              }
              def self.variants
              end

            end

            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            # Populated when items are returned via API.
            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(
                  Symbol,
                  OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status
                )
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          sig {
            override.returns(T::Array[OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Variants])
          }
          def self.variants
          end

        end

        sig { override.returns(T::Array[OpenAI::Responses::ResponseSteerInput::Variants]) }
        def self.variants
        end

        ResponseSteerInputItemListArray = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList],
          OpenAI::Internal::Type::Converter
        )

      end

    end

  end
end
