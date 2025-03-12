# typed: strong

module OpenAI
  module Models
    UploadPart = T.type_alias { Uploads::UploadPart }

    module Uploads
      class UploadPart < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(String) }
        def upload_id
        end

        sig { params(_: String).returns(String) }
        def upload_id=(_)
        end

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
  end
end
