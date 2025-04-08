# typed: strong

module OpenAI
  module Models
    class EvalUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # Rename the evaluation.
      sig { returns(T.nilable(String)) }
      attr_reader :name

      sig { params(name: String).void }
      attr_writer :name

      sig do
        params(
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(metadata: nil, name: nil, request_options: {}); end

      sig do
        override
          .returns(
            {
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end
    end
  end
end
