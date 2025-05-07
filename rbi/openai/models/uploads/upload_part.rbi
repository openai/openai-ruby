# typed: strong

module OpenAI
  module Models
    UploadPart = Uploads::UploadPart

    module Uploads
      class UploadPart < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The upload Part unique identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the Part was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The object type, which is always `upload.part`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The ID of the Upload object that this Part was added to.
        sig { returns(String) }
        attr_accessor :upload_id

        # The upload Part represents a chunk of bytes we can add to an Upload object.
        sig do
          params(
            id: String,
            created_at: Integer,
            upload_id: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The upload Part unique identifier, which can be referenced in API endpoints.
          id:,
          # The Unix timestamp (in seconds) for when the Part was created.
          created_at:,
          # The ID of the Upload object that this Part was added to.
          upload_id:,
          # The object type, which is always `upload.part`.
          object: :"upload.part"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              object: Symbol,
              upload_id: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
