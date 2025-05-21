# typed: strong

module OpenAI
  module Models
    module Containers
      class FileCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Containers::FileCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # The File object (not file name) to be uploaded.
        sig { returns(T.nilable(OpenAI::Internal::FileInput)) }
        attr_reader :file

        sig { params(file: OpenAI::Internal::FileInput).void }
        attr_writer :file

        # Name of the file to create.
        sig { returns(T.nilable(String)) }
        attr_reader :file_id

        sig { params(file_id: String).void }
        attr_writer :file_id

        sig do
          params(
            file: OpenAI::Internal::FileInput,
            file_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The File object (not file name) to be uploaded.
          file: nil,
          # Name of the file to create.
          file_id: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              file: OpenAI::Internal::FileInput,
              file_id: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
