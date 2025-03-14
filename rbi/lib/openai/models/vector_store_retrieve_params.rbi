# typed: strong

module OpenAI
  module Models
    class VectorStoreRetrieveParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig do
        params(request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          .returns(T.attached_class)
      end
      def self.new(request_options: {})
      end

      sig { override.returns({request_options: OpenAI::RequestOptions}) }
      def to_hash
      end
    end
  end
end
