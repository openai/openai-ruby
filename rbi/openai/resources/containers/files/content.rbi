# typed: strong

module OpenAI
  module Resources
    class Containers
      class Files
        class Content
          sig { returns(Content::WithRawResponse) }
          def with_raw_response
          end

          # Retrieve Container File Content
          sig do
            params(
              file_id: String,
              container_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(StringIO)
          end
          def retrieve(file_id, container_id:, request_options: {})
          end

          # @api private
          sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
          def self.new(client:)
          end

          class WithRawResponse
            sig { params(file_id: String, container_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[StringIO]) }
            def retrieve(file_id, container_id:, request_options: {})
            end

            # @api private
            sig { params(resource: Content).returns(T.attached_class) }
            def self.new(resource:)
            end
          end
        end
      end
    end
  end
end
