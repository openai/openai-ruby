# typed: strong

module OpenAI
  module Resources
    class Containers
      sig { returns(OpenAI::Resources::Containers::Files) }
      attr_reader :files

      # Create Container
      sig do
        params(
          name: String,
          expires_after: OpenAI::ContainerCreateParams::ExpiresAfter::OrHash,
          file_ids: T::Array[String],
          memory_limit: OpenAI::ContainerCreateParams::MemoryLimit::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::ContainerCreateResponse)
      end
      def create(
        # Name of the container to create.
        name:,
        # Container expiration time in seconds relative to the 'anchor' time.
        expires_after: nil,
        # IDs of files to copy to the container.
        file_ids: nil,
        # Optional memory limit for the container. Defaults to "1g".
        memory_limit: nil,
        request_options: {}
      )
      end

      # Retrieve Container
      sig do
        params(
          container_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::ContainerRetrieveResponse)
      end
      def retrieve(container_id, request_options: {})
      end

      # List Containers
      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::ContainerListParams::Order::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(
          OpenAI::Internal::CursorPage[OpenAI::Models::ContainerListResponse]
        )
      end
      def list(
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

      # Delete Container
      sig do
        params(
          container_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).void
      end
      def delete(
        # The ID of the container to delete.
        container_id,
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
