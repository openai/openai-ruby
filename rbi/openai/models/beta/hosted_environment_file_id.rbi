# typed: strong

module OpenAI
  module Models

    module Beta

      class HostedEnvironmentFileID < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::HostedEnvironmentFileID,
            OpenAI::Internal::AnyHash
          )
        end

        # The session-scoped ID of the file in the execution environment.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the uploaded file.
        sig { returns(String) }
        attr_accessor :file_id

        # The file's absolute path inside the environment.
        sig { returns(String) }
        attr_accessor :path

        # The decoded file size in bytes.
        sig { returns(Integer) }
        attr_accessor :size_bytes

        # The type of the object. Always `file_id`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A file copied from the OpenAI Files API.
        sig do
          params(

            id: String,

            file_id: String,

            path: String,

            size_bytes: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The session-scoped ID of the file in the execution environment.
          id:,

          # The ID of the uploaded file.
          file_id:,

          # The file's absolute path inside the environment.
          path:,

          # The decoded file size in bytes.
          size_bytes:,

          # The type of the object. Always `file_id`.

          type: :file_id
        )
        end

        sig do
          override.returns(
            {id: String, file_id: String, path: String, size_bytes: Integer, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
