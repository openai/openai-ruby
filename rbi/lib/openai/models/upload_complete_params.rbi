# typed: strong

module OpenAI
  module Models
    class UploadCompleteParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T::Array[String]) }
      def part_ids
      end

      sig { params(_: T::Array[String]).returns(T::Array[String]) }
      def part_ids=(_)
      end

      sig { returns(T.nilable(String)) }
      def md5
      end

      sig { params(_: String).returns(String) }
      def md5=(_)
      end

      sig do
        params(
          part_ids: T::Array[String],
          md5: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(part_ids:, md5: nil, request_options: {})
      end

      sig do
        override.returns({part_ids: T::Array[String], md5: String, request_options: OpenAI::RequestOptions})
      end
      def to_hash
      end
    end
  end
end
