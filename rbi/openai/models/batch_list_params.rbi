# typed: strong

module OpenAI
  module Models
    class BatchListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # A cursor for use in pagination. `after` is an object ID that defines your place
      # in the list. For instance, if you make a list request and receive 100 objects,
      # ending with obj_foo, your subsequent call can include after=obj_foo in order to
      # fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      attr_reader :after

      sig { params(after: String).void }
      attr_writer :after

      # A limit on the number of objects to be returned. Limit can range between 1 and
      # 100, and the default is 20.
      sig { returns(T.nilable(Integer)) }
      attr_reader :limit

      sig { params(limit: Integer).void }
      attr_writer :limit

      sig do
        params(
          after: String,
          limit: Integer,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        # A cursor for use in pagination. `after` is an object ID that defines your place
        # in the list. For instance, if you make a list request and receive 100 objects,
        # ending with obj_foo, your subsequent call can include after=obj_foo in order to
        # fetch the next page of the list.
        after: nil,
        # A limit on the number of objects to be returned. Limit can range between 1 and
        # 100, and the default is 20.
        limit: nil,
        request_options: {}
      ); end
      sig { override.returns({after: String, limit: Integer, request_options: OpenAI::RequestOptions}) }
      def to_hash; end
    end
  end
end
