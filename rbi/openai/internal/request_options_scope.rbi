# typed: strong

module OpenAI
  module Internal
    # @api private
    class RequestOptionsScope
      sig do
        params(
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        )
          .returns(T.attached_class)
      end
      def self.new(request_options)
      end

      sig { params(operation: String).returns(OpenAI::Internal::AnyHash) }
      def child(operation)
      end
    end
  end
end
