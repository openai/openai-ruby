# typed: strong

module OpenAI
  module Models
    module Conversations
      class InputFileContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::InputFileContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The URL of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :file_url

        sig { params(file_url: String).void }
        attr_writer :file_url

        # The name of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :filename

        sig { params(filename: String).void }
        attr_writer :filename

        sig do
          params(
            file_id: T.nilable(String),
            file_url: String,
            filename: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the file to be sent to the model.
          file_id:,
          # The URL of the file to be sent to the model.
          file_url: nil,
          # The name of the file to be sent to the model.
          filename: nil,
          # The type of the input item. Always `input_file`.
          type: :input_file
        )
        end

        sig do
          override.returns(
            {
              file_id: T.nilable(String),
              type: Symbol,
              file_url: String,
              filename: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
