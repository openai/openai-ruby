# typed: strong

module OpenAI
  module Models
    module Responses
      # A message input to the model with a role indicating instruction following
      #   hierarchy. Instructions given with the `developer` or `system` role take
      #   precedence over instructions given with the `user` role. Messages with the
      #   `assistant` role are presumed to have been generated by the model in previous
      #   interactions.
      module ResponseInputItem
        extend OpenAI::Union

        class Message < OpenAI::BaseModel
          # A list of one or many input items to the model, containing different content
          #   types.
          sig do
            returns(
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ]
            )
          end
          attr_accessor :content

          # The role of the message input. One of `user`, `system`, or `developer`.
          sig { returns(OpenAI::Models::Responses::ResponseInputItem::Message::Role::OrSymbol) }
          attr_accessor :role

          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputItem::Message::Status::OrSymbol)) }
          attr_reader :status

          sig { params(status: OpenAI::Models::Responses::ResponseInputItem::Message::Status::OrSymbol).void }
          attr_writer :status

          # The type of the message input. Always set to `message`.
          sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputItem::Message::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Models::Responses::ResponseInputItem::Message::Type::OrSymbol).void }
          attr_writer :type

          # A message input to the model with a role indicating instruction following
          #   hierarchy. Instructions given with the `developer` or `system` role take
          #   precedence over instructions given with the `user` role.
          sig do
            params(
              content: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Util::AnyHash,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ],
              role: OpenAI::Models::Responses::ResponseInputItem::Message::Role::OrSymbol,
              status: OpenAI::Models::Responses::ResponseInputItem::Message::Status::OrSymbol,
              type: OpenAI::Models::Responses::ResponseInputItem::Message::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, status: nil, type: nil)
          end

          sig do
            override
              .returns(
                {
                  content: T::Array[
                  T.any(
                    OpenAI::Models::Responses::ResponseInputText,
                    OpenAI::Models::Responses::ResponseInputImage,
                    OpenAI::Models::Responses::ResponseInputFile
                  )
                  ],
                  role: OpenAI::Models::Responses::ResponseInputItem::Message::Role::OrSymbol,
                  status: OpenAI::Models::Responses::ResponseInputItem::Message::Status::OrSymbol,
                  type: OpenAI::Models::Responses::ResponseInputItem::Message::Type::OrSymbol
                }
              )
          end
          def to_hash
          end

          # The role of the message input. One of `user`, `system`, or `developer`.
          module Role
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Role) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputItem::Message::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::Responses::ResponseInputItem::Message::Role::TaggedSymbol)
            SYSTEM = T.let(:system, OpenAI::Models::Responses::ResponseInputItem::Message::Role::TaggedSymbol)
            DEVELOPER = T.let(:developer, OpenAI::Models::Responses::ResponseInputItem::Message::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputItem::Message::Role::TaggedSymbol]) }
            def self.values
            end
          end

          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          module Status
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Status) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputItem::Message::Status::TaggedSymbol) }

            IN_PROGRESS =
              T.let(:in_progress, OpenAI::Models::Responses::ResponseInputItem::Message::Status::TaggedSymbol)
            COMPLETED =
              T.let(:completed, OpenAI::Models::Responses::ResponseInputItem::Message::Status::TaggedSymbol)
            INCOMPLETE =
              T.let(:incomplete, OpenAI::Models::Responses::ResponseInputItem::Message::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputItem::Message::Status::TaggedSymbol]) }
            def self.values
            end
          end

          # The type of the message input. Always set to `message`.
          module Type
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Type) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputItem::Message::Type::TaggedSymbol) }

            MESSAGE = T.let(:message, OpenAI::Models::Responses::ResponseInputItem::Message::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputItem::Message::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class ComputerCallOutput < OpenAI::BaseModel
          # The ID of the computer tool call that produced the output.
          sig { returns(String) }
          attr_accessor :call_id

          # A computer screenshot image used with the computer use tool.
          sig { returns(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot) }
          attr_reader :output

          sig do
            params(
              output: T.any(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot, OpenAI::Util::AnyHash)
            )
              .void
          end
          attr_writer :output

          # The type of the computer tool call output. Always `computer_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The ID of the computer tool call output.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # The safety checks reported by the API that have been acknowledged by the
          #   developer.
          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck]
              )
            )
          end
          attr_reader :acknowledged_safety_checks

          sig do
            params(
              acknowledged_safety_checks: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck,
                OpenAI::Util::AnyHash
              )
              ]
            )
              .void
          end
          attr_writer :acknowledged_safety_checks

          # The status of the message input. One of `in_progress`, `completed`, or
          #   `incomplete`. Populated when input items are returned via API.
          sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::OrSymbol)) }
          attr_reader :status

          sig { params(status: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::OrSymbol).void }
          attr_writer :status

          # The output of a computer tool call.
          sig do
            params(
              call_id: String,
              output: T.any(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot, OpenAI::Util::AnyHash),
              id: String,
              acknowledged_safety_checks: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck,
                OpenAI::Util::AnyHash
              )
              ],
              status: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::OrSymbol,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(
            call_id:,
            output:,
            id: nil,
            acknowledged_safety_checks: nil,
            status: nil,
            type: :computer_call_output
          )
          end

          sig do
            override
              .returns(
                {
                  call_id: String,
                  output: OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot,
                  type: Symbol,
                  id: String,
                  acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck],
                  status: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::OrSymbol
                }
              )
          end
          def to_hash
          end

          class AcknowledgedSafetyCheck < OpenAI::BaseModel
            # The ID of the pending safety check.
            sig { returns(String) }
            attr_accessor :id

            # The type of the pending safety check.
            sig { returns(String) }
            attr_accessor :code

            # Details about the pending safety check.
            sig { returns(String) }
            attr_accessor :message

            # A pending safety check for the computer call.
            sig { params(id: String, code: String, message: String).returns(T.attached_class) }
            def self.new(id:, code:, message:)
            end

            sig { override.returns({id: String, code: String, message: String}) }
            def to_hash
            end
          end

          # The status of the message input. One of `in_progress`, `completed`, or
          #   `incomplete`. Populated when input items are returned via API.
          module Status
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status) }
            OrSymbol =
              T.type_alias do
                T.any(
                  Symbol,
                  String,
                  OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::TaggedSymbol
                )
              end

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(:completed, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::TaggedSymbol)
            INCOMPLETE =
              T.let(:incomplete, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::TaggedSymbol)

            sig do
              override
                .returns(T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status::TaggedSymbol])
            end
            def self.values
            end
          end
        end

        class FunctionCallOutput < OpenAI::BaseModel
          # The unique ID of the function tool call generated by the model.
          sig { returns(String) }
          attr_accessor :call_id

          # A JSON string of the output of the function tool call.
          sig { returns(String) }
          attr_accessor :output

          # The type of the function tool call output. Always `function_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The unique ID of the function tool call output. Populated when this item is
          #   returned via API.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::OrSymbol)) }
          attr_reader :status

          sig { params(status: OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::OrSymbol).void }
          attr_writer :status

          # The output of a function tool call.
          sig do
            params(
              call_id: String,
              output: String,
              id: String,
              status: OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::OrSymbol,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(call_id:, output:, id: nil, status: nil, type: :function_call_output)
          end

          sig do
            override
              .returns(
                {
                  call_id: String,
                  output: String,
                  type: Symbol,
                  id: String,
                  status: OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::OrSymbol
                }
              )
          end
          def to_hash
          end

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          module Status
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status) }
            OrSymbol =
              T.type_alias do
                T.any(
                  Symbol,
                  String,
                  OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::TaggedSymbol
                )
              end

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(:completed, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::TaggedSymbol)
            INCOMPLETE =
              T.let(:incomplete, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::TaggedSymbol)

            sig do
              override
                .returns(T::Array[OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status::TaggedSymbol])
            end
            def self.values
            end
          end
        end

        class ItemReference < OpenAI::BaseModel
          # The ID of the item to reference.
          sig { returns(String) }
          attr_accessor :id

          # The type of item to reference. Always `item_reference`.
          sig { returns(Symbol) }
          attr_accessor :type

          # An internal identifier for an item to reference.
          sig { params(id: String, type: Symbol).returns(T.attached_class) }
          def self.new(id:, type: :item_reference)
          end

          sig { override.returns({id: String, type: Symbol}) }
          def to_hash
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference]
            )
        end
        def self.variants
        end
      end
    end
  end
end
