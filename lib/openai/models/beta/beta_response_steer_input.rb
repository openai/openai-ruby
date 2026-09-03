# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Input to queue for a continuation of the response. Uses the same string or
      # input-item shape as `response.create.input`, with a non-empty array when
      # supplying input items.
      #
      # Steering accepts only messages with the `user` role. Each message may contain
      # only `type`, `role`, and `content`, with `content` as a string or an array of
      # `input_text`, `input_image`, and `input_file` parts. The optional `type` must be
      # `message`. Other roles, tool outputs, and item types are not supported for
      # steering.
      module BetaResponseSteerInput
        extend OpenAI::Internal::Type::Union

        # A text input, equivalent to a message with the `user` role.
        variant String

        # A non-empty list of message inputs to queue for the response.
        variant -> { OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemListArray }

        # The output of a function tool call.
        module ResponseSteerInputItemList
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :message, -> { OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message }

          # The output of a function tool call.
          variant(
            :function_call_output,
            -> { OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput }
          )

          class Message < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The message content, as an array of content parts.
            #
            #   @return [Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>, String]
            required(
              :content,
              union: -> { OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message::Content }
            )

            # @!attribute role
            #   The message role. Always `user`.
            #
            #   @return [Symbol, :user]
            required :role, const: :user

            # @!attribute type
            #   The item type. Always `message`.
            #
            #   @return [Symbol, :message]
            required :type, const: :message

            # @!attribute id
            #   The unique ID of this message item.
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute agent
            #   The agent that produced this item.
            #
            #   @return [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message::Agent, nil]
            optional(
              :agent,
              -> { OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message::Agent },
              nil?: true
            )

            # @!attribute status
            #   The status of the message item.
            #
            #   @return [String, nil]
            optional :status, String, nil?: true

            # @!method initialize(content:, id: nil, agent: nil, status: nil, role: :user, type: :message)
            #   @param content [Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>, String] The message content, as an array of content parts.
            #
            #   @param id [String, nil] The unique ID of this message item.
            #
            #   @param agent [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message::Agent, nil] The agent that produced this item.
            #
            #   @param status [String, nil] The status of the message item.
            #
            #   @param role [Symbol, :user] The message role. Always `user`.
            #
            #   @param type [Symbol, :message] The item type. Always `message`.

            # The message content, as an array of content parts.
            #
            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message#content
            module Content
              extend OpenAI::Internal::Type::Union

              variant(
                -> {
                  OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message::Content::BetaResponseSteerInputContentArray
                }
              )

              # The message content, as a single string.
              variant String

              # @!method self.variants
              #   @return [Array(Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>, String)]

              # @type [OpenAI::Internal::Type::Converter]
              BetaResponseSteerInputContentArray = OpenAI::Internal::Type::ArrayOf[
                union: -> { OpenAI::Beta::BetaResponseSteerInputContent }
              ]
            end

            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message#agent
            class Agent < OpenAI::Internal::Type::BaseModel
              # @!attribute agent_name
              #   The canonical name of the agent that produced this item.
              #
              #   @return [String]
              required :agent_name, String

              # @!method initialize(agent_name:)
              #   The agent that produced this item.
              #
              #   @param agent_name [String] The canonical name of the agent that produced this item.
            end
          end

          class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
            # @!attribute output
            #   Text, image, or file output of the function tool call.
            #
            #   @return [String, Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>]
            required(
              :output,
              union: -> {
                OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Output
              }
            )

            # @!attribute type
            #   The type of the function tool call output. Always `function_call_output`.
            #
            #   @return [Symbol, :function_call_output]
            required :type, const: :function_call_output

            # @!attribute id
            #   The unique ID of the function tool call output. Populated when this item is
            #   returned via API.
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute agent
            #   The agent that produced this item.
            #
            #   @return [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Agent, nil]
            optional(
              :agent,
              -> {
                OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Agent
              },
              nil?: true
            )

            # @!attribute call_id
            #   The unique ID of the function tool call generated by the model.
            #
            #   @return [String, nil]
            optional :call_id, String, nil?: true

            # @!attribute caller_
            #   The execution context that produced this tool call.
            #
            #   @return [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program, nil]
            optional(
              :caller_,
              union: -> {
                OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller
              },
              api_name: :caller,
              nil?: true
            )

            # @!attribute name
            #   The name of the tool that produced the output.
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute namespace
            #   The namespace of the tool that produced the output.
            #
            #   @return [String, nil]
            optional :namespace, String, nil?: true

            # @!attribute status
            #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status, nil]
            optional(
              :status,
              enum: -> {
                OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status
              },
              nil?: true
            )

            # @!method initialize(output:, id: nil, agent: nil, call_id: nil, caller_: nil, name: nil, namespace: nil, status: nil, type: :function_call_output)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput}
            #   for more details.
            #
            #   The output of a function tool call.
            #
            #   @param output [String, Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>] Text, image, or file output of the function tool call.
            #
            #   @param id [String, nil] The unique ID of the function tool call output. Populated when this item is retu
            #
            #   @param agent [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Agent, nil] The agent that produced this item.
            #
            #   @param call_id [String, nil] The unique ID of the function tool call generated by the model.
            #
            #   @param caller_ [OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program, nil] The execution context that produced this tool call.
            #
            #   @param name [String, nil] The name of the tool that produced the output.
            #
            #   @param namespace [String, nil] The namespace of the tool that produced the output.
            #
            #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Status, nil] The status of the item. One of `in_progress`, `completed`, or `incomplete`. Popu
            #
            #   @param type [Symbol, :function_call_output] The type of the function tool call output. Always `function_call_output`.

            # Text, image, or file output of the function tool call.
            #
            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput#output
            module Output
              extend OpenAI::Internal::Type::Union

              # A JSON string of the output of the function tool call.
              variant String

              # An array of content outputs (text, image, file) for the function tool call.
              variant -> { OpenAI::Beta::BetaResponseFunctionCallOutputItemList }

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent>)]
            end

            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput#agent
            class Agent < OpenAI::Internal::Type::BaseModel
              # @!attribute agent_name
              #   The canonical name of the agent that produced this item.
              #
              #   @return [String]
              required :agent_name, String

              # @!method initialize(agent_name:)
              #   The agent that produced this item.
              #
              #   @param agent_name [String] The canonical name of the agent that produced this item.
            end

            # The execution context that produced this tool call.
            #
            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput#caller_
            module Caller
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant(
                :direct,
                -> {
                  OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct
                }
              )

              variant(
                :program,
                -> {
                  OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program
                }
              )

              class Direct < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The caller type. Always `direct`.
                #
                #   @return [Symbol, :direct]
                required :type, const: :direct

                # @!method initialize(type: :direct)
                #   @param type [Symbol, :direct] The caller type. Always `direct`.
              end

              class Program < OpenAI::Internal::Type::BaseModel
                # @!attribute caller_id
                #   The call ID of the program item that produced this tool call.
                #
                #   @return [String]
                required :caller_id, String

                # @!attribute type
                #   The caller type. Always `program`.
                #
                #   @return [Symbol, :program]
                required :type, const: :program

                # @!method initialize(caller_id:, type: :program)
                #   @param caller_id [String] The call ID of the program item that produced this tool call.
                #
                #   @param type [Symbol, :program] The caller type. Always `program`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Direct, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput::Caller::Program)]
            end

            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            # Populated when items are returned via API.
            #
            # @see OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Message, OpenAI::Models::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::FunctionCallOutput)]
        end

        # @!method self.variants
        #   @return [Array(String, Array<Hash{Symbol=>Object}>)]

        # @type [OpenAI::Internal::Type::Converter]
        ResponseSteerInputItemListArray = OpenAI::Internal::Type::ArrayOf[
          union: -> {
            OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList
          }
        ]
      end
    end

    BetaResponseSteerInput = Beta::BetaResponseSteerInput
  end
end
