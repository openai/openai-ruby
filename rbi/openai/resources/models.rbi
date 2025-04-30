# typed: strong

module OpenAI
  module Resources
    class Models
      # Retrieves a model instance, providing basic information about the model such as
      # the owner and permissioning.
      sig { params(model: String, request_options: OpenAI::RequestOpts).returns(OpenAI::Models::Model) }
      def retrieve(
        # The ID of the model to use for this request
        model,
        request_options: {}
      ); end
      # Lists the currently available models, and provides basic information about each
      # one such as the owner and availability.
      sig { params(request_options: OpenAI::RequestOpts).returns(OpenAI::Internal::Page[OpenAI::Models::Model]) }
      def list(request_options: {}); end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      # delete a model.
      sig { params(model: String, request_options: OpenAI::RequestOpts).returns(OpenAI::Models::ModelDeleted) }
      def delete(
        # The model to delete
        model,
        request_options: {}
      ); end
      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:); end
    end
  end
end
