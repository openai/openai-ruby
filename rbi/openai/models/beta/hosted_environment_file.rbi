# typed: strong

module OpenAI
  module Models

    module Beta

      # Metadata for a file materialized in an OpenAI-hosted execution environment.
      module HostedEnvironmentFile
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::HostedEnvironmentFileID,
            OpenAI::Beta::HostedEnvironmentFile::Inline
          )
        end

        class Inline < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedEnvironmentFile::Inline,
              OpenAI::Internal::AnyHash
            )
          end

          # The session-scoped ID of the file in the execution environment.
          sig { returns(String) }
          attr_accessor :id

          # The file's absolute path inside the environment.
          sig { returns(String) }
          attr_accessor :path

          # The decoded file size in bytes.
          sig { returns(Integer) }
          attr_accessor :size_bytes

          # The type of the object. Always `inline`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A file supplied inline when the session was created.
          sig do
            params(

              id: String,

              path: String,

              size_bytes: Integer,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The session-scoped ID of the file in the execution environment.
            id:,

            # The file's absolute path inside the environment.
            path:,

            # The decoded file size in bytes.
            size_bytes:,

            # The type of the object. Always `inline`.

            type: :inline
          )
          end

          sig do
            override.returns(
              {id: String, path: String, size_bytes: Integer, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::HostedEnvironmentFile::Variants]) }
        def self.variants
        end

      end

    end

  end
end
