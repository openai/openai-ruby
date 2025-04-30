# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the code interpreter tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute code
        #   The code to run.
        #
        #   @return [String]
        required :code, String

        # @!attribute results
        #   The results of the code interpreter tool call.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files>]
        required :results,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result] }

        # @!attribute status
        #   The status of the code interpreter tool call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status]
        required :status, enum: -> { OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status }

        # @!attribute type
        #   The type of the code interpreter tool call. Always `code_interpreter_call`.
        #
        #   @return [Symbol, :code_interpreter_call]
        required :type, const: :code_interpreter_call

        # @!method initialize(id:, code:, results:, status:, type: :code_interpreter_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterToolCall} for more details.
        #
        #   A tool call to run code.
        #
        #   @param id [String] The unique ID of the code interpreter tool call. ...
        #
        #   @param code [String] The code to run. ...
        #
        #   @param results [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files>] The results of the code interpreter tool call. ...
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status] The status of the code interpreter tool call. ...
        #
        #   @param type [Symbol, :code_interpreter_call] The type of the code interpreter tool call. Always `code_interpreter_call`. ...

        # The output of a code interpreter tool call that is text.
        module Result
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # The output of a code interpreter tool call that is text.
          variant :logs, -> { OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs }

          # The output of a code interpreter tool call that is a file.
          variant :files, -> { OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files }

          class Logs < OpenAI::Internal::Type::BaseModel
            # @!attribute logs
            #   The logs of the code interpreter tool call.
            #
            #   @return [String]
            required :logs, String

            # @!attribute type
            #   The type of the code interpreter text output. Always `logs`.
            #
            #   @return [Symbol, :logs]
            required :type, const: :logs

            # @!method initialize(logs:, type: :logs)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs} for
            #   more details.
            #
            #   The output of a code interpreter tool call that is text.
            #
            #   @param logs [String] The logs of the code interpreter tool call. ...
            #
            #   @param type [Symbol, :logs] The type of the code interpreter text output. Always `logs`. ...
          end

          class Files < OpenAI::Internal::Type::BaseModel
            # @!attribute files
            #
            #   @return [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File>]
            required :files,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File] }

            # @!attribute type
            #   The type of the code interpreter file output. Always `files`.
            #
            #   @return [Symbol, :files]
            required :type, const: :files

            # @!method initialize(files:, type: :files)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files} for
            #   more details.
            #
            #   The output of a code interpreter tool call that is a file.
            #
            #   @param files [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File>]
            #
            #   @param type [Symbol, :files] The type of the code interpreter file output. Always `files`. ...

            class File < OpenAI::Internal::Type::BaseModel
              # @!attribute file_id
              #   The ID of the file.
              #
              #   @return [String]
              required :file_id, String

              # @!attribute mime_type
              #   The MIME type of the file.
              #
              #   @return [String]
              required :mime_type, String

              # @!method initialize(file_id:, mime_type:)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files::File}
              #   for more details.
              #
              #   @param file_id [String] The ID of the file. ...
              #
              #   @param mime_type [String] The MIME type of the file. ...
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Result::Files)]
        end

        # The status of the code interpreter tool call.
        #
        # @see OpenAI::Models::Responses::ResponseCodeInterpreterToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          INTERPRETING = :interpreting
          COMPLETED = :completed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
