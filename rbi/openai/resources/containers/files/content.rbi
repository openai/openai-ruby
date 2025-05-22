# typed: strong

module OpenAI
  module Resources
    class Containers
      class Files
        class Content
          # Retrieve Container File Content
          sig do
            params(
              file_id: String,
              container_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).void
          end
          def retrieve(file_id, container_id:, request_options: {})
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
