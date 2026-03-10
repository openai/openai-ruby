# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputFileContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputFileContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The base64-encoded data of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_data

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_url

        # The name of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :filename

        # A file input to the model.
        sig do
          params(
            file_data: T.nilable(String),
            file_id: T.nilable(String),
            file_url: T.nilable(String),
            filename: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The base64-encoded data of the file to be sent to the model.
          file_data: nil,
          # The ID of the file to be sent to the model.
          file_id: nil,
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
              type: Symbol,
              file_data: T.nilable(String),
              file_id: T.nilable(String),
              file_url: T.nilable(String),
              filename: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
