# typed: strong

module OpenAI
  module Models
    module Containers
      class FileRetrieveResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::Containers::FileRetrieveResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique identifier for the file.
        sig { returns(String) }
        attr_accessor :id

        # Size of the file in bytes.
        sig { returns(Integer) }
        attr_accessor :bytes

        # The container this file belongs to.
        sig { returns(String) }
        attr_accessor :container_id

        # Unix timestamp (in seconds) when the file was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The type of this object (`container.file`).
        sig { returns(Symbol) }
        attr_accessor :object

        # Path of the file in the container.
        sig { returns(String) }
        attr_accessor :path

        # Source of the file (e.g., `user`, `assistant`).
        sig { returns(String) }
        attr_accessor :source

        sig do
          params(
            id: String,
            bytes: Integer,
            container_id: String,
            created_at: Integer,
            path: String,
            source: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the file.
          id:,
          # Size of the file in bytes.
          bytes:,
          # The container this file belongs to.
          container_id:,
          # Unix timestamp (in seconds) when the file was created.
          created_at:,
          # Path of the file in the container.
          path:,
          # Source of the file (e.g., `user`, `assistant`).
          source:,
          # The type of this object (`container.file`).
          object: :"container.file"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              bytes: Integer,
              container_id: String,
              created_at: Integer,
              object: Symbol,
              path: String,
              source: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
