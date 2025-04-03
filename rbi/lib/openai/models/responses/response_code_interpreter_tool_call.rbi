# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterToolCall < OpenAI::BaseModel
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
            T.any(
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
            )
            ]
          )
        end
        attr_accessor :results

        # The status of the code interpreter tool call.
        sig { returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol) }
        attr_accessor :status

        # The type of the code interpreter tool call. Always `code_interpreter_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool call to run code.
        sig do
          params(
            id: String,
            code: String,
            results: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
              OpenAI::Internal::Util::AnyHash,
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
            )
            ],
            status: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, code:, results:, status:, type: :code_interpreter_call)
        end

        sig do
          override
            .returns(
              {
                id: String,
                code: String,
                results: T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
                  OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
                )
                ],
                status: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # The output of a code interpreter tool call that is text.
        module Result
          extend OpenAI::Union

          class Logs < OpenAI::BaseModel
            # The logs of the code interpreter tool call.
            sig { returns(String) }
            attr_accessor :logs

            # The type of the code interpreter text output. Always `logs`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The output of a code interpreter tool call that is text.
            sig { params(logs: String, type: Symbol).returns(T.attached_class) }
            def self.new(logs:, type: :logs)
            end

            sig { override.returns({logs: String, type: Symbol}) }
            def to_hash
            end
          end

          class Files < OpenAI::BaseModel
            sig { returns(T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File]) }
            attr_accessor :files

            # The type of the code interpreter file output. Always `files`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The output of a code interpreter tool call that is a file.
            sig do
              params(
                files: T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File,
                  OpenAI::Internal::Util::AnyHash
                )
                ],
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(files:, type: :files)
            end

            sig do
              override
                .returns(
                  {
                    files: T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File],
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            class File < OpenAI::BaseModel
              # The ID of the file.
              sig { returns(String) }
              attr_accessor :file_id

              # The MIME type of the file.
              sig { returns(String) }
              attr_accessor :mime_type

              sig { params(file_id: String, mime_type: String).returns(T.attached_class) }
              def self.new(file_id:, mime_type:)
              end

              sig { override.returns({file_id: String, mime_type: String}) }
              def to_hash
              end
            end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files]
              )
          end
          def self.variants
          end
        end

        # The status of the code interpreter tool call.
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
          INTERPRETING =
            T.let(:interpreting, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol])
          end
          def self.values
          end
        end
      end
    end
  end
end
