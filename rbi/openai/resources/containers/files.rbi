# typed: strong

module OpenAI
  module Resources
    class Containers
      class Files
        sig { returns(Files::WithRawResponse) }
        def with_raw_response
        end

        sig { returns(OpenAI::Resources::Containers::Files::Content) }
        attr_reader :content

        # Create a Container File
        #
        # You can send either a multipart/form-data request with the raw file content, or
        # a JSON request with a file ID.
        sig do
          params(
            container_id: String,
            file: OpenAI::Internal::FileInput,
            file_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Containers::FileCreateResponse)
        end
        def create(
          container_id,
          # The File object (not file name) to be uploaded.
          file: nil,
          # Name of the file to create.
          file_id: nil,
          request_options: {}
        )
        end

        # Retrieve Container File
        sig do
          params(
            file_id: String,
            container_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Containers::FileRetrieveResponse)
        end
        def retrieve(file_id, container_id:, request_options: {})
        end

        # List Container files
        sig do
          params(
            container_id: String,
            after: String,
            limit: Integer,
            order: OpenAI::Containers::FileListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Internal::CursorPage[
              OpenAI::Models::Containers::FileListResponse
            ]
          )
        end
        def list(
          container_id,
          # A cursor for use in pagination. `after` is an object ID that defines your place
          # in the list. For instance, if you make a list request and receive 100 objects,
          # ending with obj_foo, your subsequent call can include after=obj_foo in order to
          # fetch the next page of the list.
          after: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          limit: nil,
          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          # order and `desc` for descending order.
          order: nil,
          request_options: {}
        )
        end

        # Delete Container File
        sig do
          params(
            file_id: String,
            container_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).void
        end
        def delete(file_id, container_id:, request_options: {})
        end

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { returns(OpenAI::Resources::Containers::Files::Content::WithRawResponse) }
          attr_reader :content

          sig { params(container_id: String, file: OpenAI::Internal::FileInput, file_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Containers::FileCreateResponse]) }
          def create(
            container_id,
            # The File object (not file name) to be uploaded.
            file: nil,
            # Name of the file to create.
            file_id: nil,
            request_options: {}
          )
          end

          sig { params(file_id: String, container_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Containers::FileRetrieveResponse]) }
          def retrieve(file_id, container_id:, request_options: {})
          end

          sig { params(container_id: String, after: String, limit: Integer, order: OpenAI::Containers::FileListParams::Order::OrSymbol, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::CursorPage[OpenAI::Models::Containers::FileListResponse]]) }
          def list(
            container_id,
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            order: nil,
            request_options: {}
          )
          end

          sig { params(file_id: String, container_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[NilClass]) }
          def delete(file_id, container_id:, request_options: {})
          end

          # @api private
          sig { params(resource: Files).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
