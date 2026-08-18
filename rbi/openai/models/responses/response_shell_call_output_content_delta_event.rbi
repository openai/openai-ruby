# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseShellCallOutputContentDeltaEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The index of the shell command that produced output.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The stdout/stderr delta that was emitted.
        sig { returns(OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta) }
        attr_reader :delta

        sig { params(delta: OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta::OrHash).void }
        attr_writer :delta

        # The ID of the output item that was updated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_output_content.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A streaming event that indicated shell call output was incrementally added.
        sig do
          params(

            command_index: Integer,

            delta: OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta::OrHash,

            item_id: String,

            output_index: Integer,

            sequence_number: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The index of the shell command that produced output.
          command_index:,

          # The stdout/stderr delta that was emitted.
          delta:,

          # The ID of the output item that was updated.
          item_id:,

          # The index of the output item that was updated.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The type of the event, always `response.shell_call_output_content.delta`.

          type: :"response.shell_call_output_content.delta"
        )
        end

        sig do
          override.returns(
            {
              command_index: Integer,
              delta: OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Delta < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta,
              OpenAI::Internal::AnyHash
            )
          end

          # The stderr delta that was emitted.
          sig { returns(T.nilable(String)) }
          attr_reader :stderr

          sig { params(stderr: String).void }
          attr_writer :stderr

          # The stdout delta that was emitted.
          sig { returns(T.nilable(String)) }
          attr_reader :stdout

          sig { params(stdout: String).void }
          attr_writer :stdout

          # The stdout/stderr delta that was emitted.
          sig do
            params(

              stderr: String,

              stdout: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The stderr delta that was emitted.
            stderr: nil,

            # The stdout delta that was emitted.

            stdout: nil
          )
          end

          sig do
            override.returns(
              {stderr: String, stdout: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
