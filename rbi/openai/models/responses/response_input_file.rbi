# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputFile < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputFile,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The detail level of the file to be sent to the model. Use `low` for the default
        # rendering behavior, or `high` to render the file at higher quality. Defaults to
        # `low`.
        sig do
          returns(
            T.nilable(OpenAI::Responses::ResponseInputFile::Detail::OrSymbol)
          )
        end
        attr_reader :detail

        sig do
          params(
            detail: OpenAI::Responses::ResponseInputFile::Detail::OrSymbol
          ).void
        end
        attr_writer :detail

        # The content of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :file_data

        sig { params(file_data: String).void }
        attr_writer :file_data

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

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

        # A file input to the model.
        sig do
          params(
            detail: OpenAI::Responses::ResponseInputFile::Detail::OrSymbol,
            file_data: String,
            file_id: T.nilable(String),
            file_url: String,
            filename: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the file to be sent to the model. Use `low` for the default
          # rendering behavior, or `high` to render the file at higher quality. Defaults to
          # `low`.
          detail: nil,
          # The content of the file to be sent to the model.
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
              detail: OpenAI::Responses::ResponseInputFile::Detail::OrSymbol,
              file_data: String,
              file_id: T.nilable(String),
              file_url: String,
              filename: String
            }
          )
        end
        def to_hash
        end

        # The detail level of the file to be sent to the model. Use `low` for the default
        # rendering behavior, or `high` to render the file at higher quality. Defaults to
        # `low`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseInputFile::Detail)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Responses::ResponseInputFile::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::ResponseInputFile::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputFile::Detail::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
