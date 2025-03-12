# typed: strong

module OpenAI
  module Resources
    class Uploads
      class Parts
        sig do
          params(
            upload_id: String,
            data: T.any(IO, StringIO),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Uploads::UploadPart)
        end
        def create(upload_id, data:, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
