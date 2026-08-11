# typed: strong

module OpenAI
  module Resources
    # List and describe the various models available in the API.
    class Models
      sig { returns(Models::WithRawResponse) }
      def with_raw_response
      end

      # Retrieves a model instance, providing basic information about the model such as
      # the owner and permissioning.
      sig do
        params(
          model: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Model)
      end
      def retrieve(
        # The ID of the model to use for this request
        model,
        request_options: {}
      )
      end

      # Lists the currently available models, and provides basic information about each
      # one such as the owner and availability.
      sig do
        params(request_options: OpenAI::RequestOptions::OrHash).returns(
          OpenAI::Internal::Page[OpenAI::Model]
        )
      end
      def list(request_options: {})
      end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      # delete a model.
      sig do
        params(
          model: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::ModelDeleted)
      end
      def delete(
        # The model to delete
        model,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { params(model: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Model]) }
        def retrieve(
          # The ID of the model to use for this request
          model,
          request_options: {}
        )
        end

        sig { params(request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::Page[OpenAI::Model]]) }
        def list(request_options: {})
        end

        sig { params(model: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::ModelDeleted]) }
        def delete(
          # The model to delete
          model,
          request_options: {}
        )
        end

        # @api private
        sig { params(resource: Models).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
