# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterToolCall < OpenAI::BaseModel
        # The unique ID of the code interpreter tool call.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The code to run.
        sig { returns(String) }
        def code
        end

        sig { params(_: String).returns(String) }
        def code=(_)
        end

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
        def results
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
              OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
                OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
              )
              ]
            )
        end
        def results=(_)
        end

        # The status of the code interpreter tool call.
        sig { returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
            .returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
        end
        def status=(_)
        end

        # The type of the code interpreter tool call. Always `code_interpreter_call`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A tool call to run code.
        sig do
          params(
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

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs,
                  OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files
                )
              }
            end

          class Logs < OpenAI::BaseModel
            # The logs of the code interpreter tool call.
            sig { returns(String) }
            def logs
            end

            sig { params(_: String).returns(String) }
            def logs=(_)
            end

            # The type of the code interpreter text output. Always `logs`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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
            def files
            end

            sig do
              params(_: T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File])
                .returns(T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File])
            end
            def files=(_)
            end

            # The type of the code interpreter file output. Always `files`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The output of a code interpreter tool call that is a file.
            sig do
              params(
                files: T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File],
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
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

              # The MIME type of the file.
              sig { returns(String) }
              def mime_type
              end

              sig { params(_: String).returns(String) }
              def mime_type=(_)
              end

              sig { params(file_id: String, mime_type: String).returns(T.attached_class) }
              def self.new(file_id:, mime_type:)
              end

              sig { override.returns({file_id: String, mime_type: String}) }
              def to_hash
              end
            end
          end

          class << self
            sig do
              override
                .returns(
                  [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files]
                )
            end
            def variants
            end
          end
        end

        # The status of the code interpreter tool call.
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
          INTERPRETING =
            T.let(:interpreting, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol)

          class << self
            sig do
              override
                .returns(T::Array[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status::TaggedSymbol])
            end
            def values
            end
          end
        end
      end
    end
  end
end
