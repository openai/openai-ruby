# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterToolCall < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterToolCall,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the code interpreter tool call.
        sig { returns(String) }
        attr_accessor :id

        # The code to run.
        sig { returns(String) }
        attr_accessor :code

        # The results of the code interpreter tool call.
        sig do
          returns(
            T::Array[
              OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Variants
            ]
          )
        end
        attr_accessor :results

        # The status of the code interpreter tool call.
        sig do
          returns(
            OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol
          )
        end
        attr_accessor :status

        # The type of the code interpreter tool call. Always `code_interpreter_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool call to run code.
        sig do
          params(
            id: String,
            code: String,
            results:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Logs::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files::OrHash
                )
              ],
            status:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the code interpreter tool call.
          id:,
          # The code to run.
          code:,
          # The results of the code interpreter tool call.
          results:,
          # The status of the code interpreter tool call.
          status:,
          # The type of the code interpreter tool call. Always `code_interpreter_call`.
          type: :code_interpreter_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              code: String,
              results:
                T::Array[
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Variants
                ],
              status:
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The output of a code interpreter tool call that is text.
        module Result
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files
              )
            end

          class Logs < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
                  OpenAI::Internal::AnyHash
                )
              end

            # The logs of the code interpreter tool call.
            sig { returns(String) }
            attr_accessor :logs

            # The type of the code interpreter text output. Always `logs`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The output of a code interpreter tool call that is text.
            sig { params(logs: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The logs of the code interpreter tool call.
              logs:,
              # The type of the code interpreter text output. Always `logs`.
              type: :logs
            )
            end

            sig { override.returns({ logs: String, type: Symbol }) }
            def to_hash
            end
          end

          class Files < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T::Array[
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files::File
                ]
              )
            end
            attr_accessor :files

            # The type of the code interpreter file output. Always `files`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The output of a code interpreter tool call that is a file.
            sig do
              params(
                files:
                  T::Array[
                    OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files::File::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              files:,
              # The type of the code interpreter file output. Always `files`.
              type: :files
            )
            end

            sig do
              override.returns(
                {
                  files:
                    T::Array[
                      OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files::File
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class File < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Files::File,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the file.
              sig { returns(String) }
              attr_accessor :file_id

              # The MIME type of the file.
              sig { returns(String) }
              attr_accessor :mime_type

              sig do
                params(file_id: String, mime_type: String).returns(
                  T.attached_class
                )
              end
              def self.new(
                # The ID of the file.
                file_id:,
                # The MIME type of the file.
                mime_type:
              )
              end

              sig { override.returns({ file_id: String, mime_type: String }) }
              def to_hash
              end
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Result::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The status of the code interpreter tool call.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol
            )
          INTERPRETING =
            T.let(
              :interpreting,
              OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
