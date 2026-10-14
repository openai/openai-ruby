# typed: strong

module OpenAI
  module Models

    module Beta

      # A file materialized in an OpenAI-hosted execution environment.
      module HostedEnvironmentFileParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::HostedEnvironmentFileParam::FileID,
            OpenAI::Beta::HostedEnvironmentFileParam::Inline
          )
        end

        class FileID < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedEnvironmentFileParam::FileID,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the uploaded file.
          sig { returns(String) }
          attr_accessor :file_id

          # The absolute destination path inside `/workspace`.
          sig { returns(String) }
          attr_accessor :path

          # The type of the object. Always `file_id`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A file previously uploaded through the OpenAI Files API.
          sig do
            params(

              file_id: String,

              path: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the uploaded file.
            file_id:,

            # The absolute destination path inside `/workspace`.
            path:,

            # The type of the object. Always `file_id`.

            type: :file_id
          )
          end

          sig do
            override.returns(
              {file_id: String, path: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Inline < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedEnvironmentFileParam::Inline,
              OpenAI::Internal::AnyHash
            )
          end

          # The standard-base64-encoded file contents.
          sig { returns(String) }
          attr_accessor :data

          # The absolute destination path inside `/workspace`.
          sig { returns(String) }
          attr_accessor :path

          # The type of the object. Always `inline`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A file supplied directly as standard-base64 data.
          sig do
            params(

              data: String,

              path: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The standard-base64-encoded file contents.
            data:,

            # The absolute destination path inside `/workspace`.
            path:,

            # The type of the object. Always `inline`.

            type: :inline
          )
          end

          sig do
            override.returns(
              {data: String, path: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::HostedEnvironmentFileParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
