# typed: strong

module OpenAI
  module Models
    module Conversations
      class FileCitationBody < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::FileCitationBody,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the file.
        sig { returns(String) }
        attr_accessor :file_id

        # The filename of the file cited.
        sig { returns(String) }
        attr_accessor :filename

        # The index of the file in the list of files.
        sig { returns(Integer) }
        attr_accessor :index

        # The type of the file citation. Always `file_citation`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            file_id: String,
            filename: String,
            index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the file.
          file_id:,
          # The filename of the file cited.
          filename:,
          # The index of the file in the list of files.
          index:,
          # The type of the file citation. Always `file_citation`.
          type: :file_citation
        )
        end

        sig do
          override.returns(
            { file_id: String, filename: String, index: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
