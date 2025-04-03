# typed: strong

module OpenAI
  module Resources
    class Models
      # Retrieves a model instance, providing basic information about the model such as
      #   the owner and permissioning.
      sig do
        params(
          model: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
        )
          .returns(OpenAI::Models::Model)
      end
      def retrieve(
        # The ID of the model to use for this request
        model,
        request_options: {}
      )
      end

      # Lists the currently available models, and provides basic information about each
      #   one such as the owner and availability.
      sig do
        params(request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash)))
          .returns(OpenAI::Internal::Page[OpenAI::Models::Model])
      end
      def list(request_options: {})
      end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      #   delete a model.
      sig do
        params(
          model: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
        )
          .returns(OpenAI::Models::ModelDeleted)
      end
      def delete(
        # The model to delete
        model,
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
