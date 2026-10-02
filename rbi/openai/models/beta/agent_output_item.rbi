# typed: strong

module OpenAI
  module Models

    module Beta

      # An output item produced by an agent.
      module AgentOutputItem
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionAssistantMessage,
            OpenAI::Beta::AgentReasoningItem,
            OpenAI::Beta::AgentFunctionCallItem,
            OpenAI::Beta::AgentMcpCallItem,
            OpenAI::Beta::AgentOutputItem::ComputerUseCall,
            OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest,
            OpenAI::Beta::AgentWebSearchCallItem,
            OpenAI::Beta::AgentCommandExecutionItem,
            OpenAI::Beta::AgentCreateSubagentCallItem,
            OpenAI::Beta::AgentSendSubagentInputCallItem,
            OpenAI::Beta::AgentResumeSubagentCallItem,
            OpenAI::Beta::AgentWaitForSubagentsCallItem,
            OpenAI::Beta::AgentInterruptSubagentCallItem,
            OpenAI::Beta::AgentCloseSubagentCallItem
          )
        end

        class ComputerUseCall < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentOutputItem::ComputerUseCall,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the activity item.
          sig { returns(String) }
          attr_accessor :id

          # The last screenshot emitted by the model. Null when screenshot inclusion is
          # disabled or the call emitted no screenshot.
          sig { returns(T.nilable(OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output)) }
          attr_reader :output

          sig { params(output: T.nilable(OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output::OrHash)).void }
          attr_writer :output

          # The execution status of the activity.
          sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
          attr_accessor :status

          # A model-generated description of the activity, when available.
          sig { returns(T.nilable(String)) }
          attr_accessor :title

          # The ID of the turn that contains this item.
          sig { returns(String) }
          attr_accessor :turn_id

          # The item type. Always `computer_use_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # One execution of the platform-provided computer-use capability.
          sig do
            params(

              id: String,

              output: T.nilable(OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output::OrHash),

              status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

              title: T.nilable(String),

              turn_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the activity item.
            id:,

            # The last screenshot emitted by the model. Null when screenshot inclusion is
            # disabled or the call emitted no screenshot.
            output:,

            # The execution status of the activity.
            status:,

            # A model-generated description of the activity, when available.
            title:,

            # The ID of the turn that contains this item.
            turn_id:,

            # The item type. Always `computer_use_call`.

            type: :computer_use_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                output: T.nilable(OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output),
                status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
                title: T.nilable(String),
                turn_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Output < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output,
                OpenAI::Internal::AnyHash
              )
            end

            # The complete JPEG image as a base64 data URL.
            sig { returns(String) }
            attr_accessor :image_url

            # The content type. Always `computer_screenshot`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The last screenshot emitted by the model. Null when screenshot inclusion is
            # disabled or the call emitted no screenshot.
            sig do
              params(

                image_url: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The complete JPEG image as a base64 data URL.
              image_url:,

              # The content type. Always `computer_screenshot`.

              type: :computer_screenshot
            )
            end

            sig do
              override.returns(
                {image_url: String, type: Symbol}
              )
            end
            def to_hash
            end

          end
        end

        class ComputerUseApprovalRequest < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest,
              OpenAI::Internal::AnyHash
            )
          end

          # The stable history item ID.
          sig { returns(String) }
          attr_accessor :id

          # A registered form awaiting the application's response.
          sig { returns(OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request) }
          attr_reader :request

          sig { params(request: OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::OrHash).void }
          attr_writer :request

          sig { returns(String) }
          attr_accessor :request_id

          sig { returns(String) }
          attr_accessor :turn_id

          # The item type. Always computer_use_approval_request.
          sig { returns(Symbol) }
          attr_accessor :type

          # A credential-free history record of the emitted login request.
          sig do
            params(

              id: String,

              request: OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::OrHash,

              request_id: String,

              turn_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The stable history item ID.
            id:,

            # A registered form awaiting the application's response.
            request:,

            request_id:,

            turn_id:,

            # The item type. Always computer_use_approval_request.

            type: :computer_use_approval_request
          )
          end

          sig do
            override.returns(
              {
                id: String,
                request: OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request,
                request_id: String,
                turn_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Request < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request,
                OpenAI::Internal::AnyHash
              )
            end

            # The registered form or frame origin where values will be entered.
            sig { returns(T.nilable(String)) }
            attr_accessor :credential_origin

            # Controls to render. All submitted values are sensitive.
            sig { returns(T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field]) }
            attr_accessor :fields

            # Sign-in methods. Empty for a plain form.
            sig { returns(T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option]) }
            attr_accessor :options

            # Why the agent needs the user to sign in.
            sig { returns(T.nilable(String)) }
            attr_accessor :reason

            # The type of the object. Always `browser_authentication`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A registered form awaiting the application's response.
            sig do
              params(

                credential_origin: T.nilable(String),

                fields: T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field::OrHash],

                options: T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option::OrHash],

                reason: T.nilable(String),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The registered form or frame origin where values will be entered.
              credential_origin:,

              # Controls to render. All submitted values are sensitive.
              fields:,

              # Sign-in methods. Empty for a plain form.
              options:,

              # Why the agent needs the user to sign in.
              reason:,

              # The type of the object. Always `browser_authentication`.

              type: :browser_authentication
            )
            end

            sig do
              override.returns(
                {
                  credential_origin: T.nilable(String),
                  fields: T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field],
                  options: T::Array[OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option],
                  reason: T.nilable(String),
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class Field < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field,
                  OpenAI::Internal::AnyHash
                )
              end

              # The field ID to submit as field_id in a fields entry.
              sig { returns(String) }
              attr_accessor :id

              # The label to display beside the control.
              sig { returns(String) }
              attr_accessor :label

              # Whether this control requires a nonempty value.
              sig { returns(T::Boolean) }
              attr_accessor :required

              # The rendering type, such as email, password, or text.
              sig { returns(String) }
              attr_accessor :type

              # A control in a registered browser-login form.
              sig do
                params(

                  id: String,

                  label: String,

                  required: T::Boolean,

                  type: String
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The field ID to submit as field_id in a fields entry.
                id:,

                # The label to display beside the control.
                label:,

                # Whether this control requires a nonempty value.
                required:,

                # The rendering type, such as email, password, or text.

                type:
              )
              end

              sig do
                override.returns(
                  {id: String, label: String, required: T::Boolean, type: String}
                )
              end
              def to_hash
              end

            end

            class Option < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option,
                  OpenAI::Internal::AnyHash
                )
              end

              # The option ID to submit as selected_option.
              sig { returns(String) }
              attr_accessor :id

              # IDs from the registered fields that this method accepts.
              sig { returns(T::Array[String]) }
              attr_accessor :field_ids

              # The method label to display.
              sig { returns(String) }
              attr_accessor :label

              # A sign-in method and the fields that belong to it.
              sig do
                params(

                  id: String,

                  field_ids: T::Array[String],

                  label: String
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The option ID to submit as selected_option.
                id:,

                # IDs from the registered fields that this method accepts.
                field_ids:,

                # The method label to display.

                label:
              )
              end

              sig do
                override.returns(
                  {id: String, field_ids: T::Array[String], label: String}
                )
              end
              def to_hash
              end

            end
          end
        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentOutputItem::Variants]) }
        def self.variants
        end

      end

    end

  end
end
