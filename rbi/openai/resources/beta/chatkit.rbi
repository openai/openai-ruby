# typed: strong

module OpenAI
  module Resources
    class Beta
      class ChatKit
        sig { returns(OpenAI::Resources::Beta::ChatKit::Sessions) }
        attr_reader :sessions

        sig { returns(OpenAI::Resources::Beta::ChatKit::Threads) }
        attr_reader :threads

        # Upload a ChatKit file
        sig do
          params(
            file: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Beta::ChatKitUploadFileResponse::Variants)
        end
        def upload_file(
          # Binary file contents to store with the ChatKit session. Supports PDFs and PNG,
          # JPG, JPEG, GIF, or WEBP images.
          file:,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
