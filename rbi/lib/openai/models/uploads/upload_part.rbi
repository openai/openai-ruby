# typed: strong

module OpenAI
  module Models
    module Uploads
      class UploadPart < OpenAI::BaseModel
        # The upload Part unique identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the Part was created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        # The object type, which is always `upload.part`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The ID of the Upload object that this Part was added to.
        sig { returns(String) }
        def upload_id
        end

        sig { params(_: String).returns(String) }
        def upload_id=(_)
        end

        # The upload Part represents a chunk of bytes we can add to an Upload object.
        sig do
          params(id: String, created_at: Integer, upload_id: String, object: Symbol).returns(T.attached_class)
        end
        def self.new(id:, created_at:, upload_id:, object: :"upload.part")
        end

        sig { override.returns({id: String, created_at: Integer, object: Symbol, upload_id: String}) }
        def to_hash
        end
      end
    end

    UploadPart = Uploads::UploadPart
  end
end
