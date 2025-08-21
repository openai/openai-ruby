# typed: strong

module OpenAI
  module Models
    module Conversations
      class ContainerFileCitationBody < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ContainerFileCitationBody,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the container file.
        sig { returns(String) }
        attr_accessor :container_id

        # The index of the last character of the container file citation in the message.
        sig { returns(Integer) }
        attr_accessor :end_index

        # The ID of the file.
        sig { returns(String) }
        attr_accessor :file_id

        # The filename of the container file cited.
        sig { returns(String) }
        attr_accessor :filename

        # The index of the first character of the container file citation in the message.
        sig { returns(Integer) }
        attr_accessor :start_index

        # The type of the container file citation. Always `container_file_citation`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            container_id: String,
            end_index: Integer,
            file_id: String,
            filename: String,
            start_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the container file.
          container_id:,
          # The index of the last character of the container file citation in the message.
          end_index:,
          # The ID of the file.
          file_id:,
          # The filename of the container file cited.
          filename:,
          # The index of the first character of the container file citation in the message.
          start_index:,
          # The type of the container file citation. Always `container_file_citation`.
          type: :container_file_citation
        )
        end

        sig do
          override.returns(
            {
              container_id: String,
              end_index: Integer,
              file_id: String,
              filename: String,
              start_index: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
