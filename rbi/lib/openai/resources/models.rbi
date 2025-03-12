# typed: strong

module OpenAI
  module Resources
    class Models
      sig do
        params(
          model: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Model)
      end
      def retrieve(model, request_options: {})
      end

      sig do
        params(request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])))
          .returns(OpenAI::Page[OpenAI::Models::Model])
      end
      def list(request_options: {})
      end

      sig do
        params(
          model: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::ModelDeleted)
      end
      def delete(model, request_options: {})
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
