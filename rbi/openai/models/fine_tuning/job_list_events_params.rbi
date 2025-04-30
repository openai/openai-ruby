# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobListEventsParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Identifier for the last event from the previous pagination request.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Number of events to retrieve.
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
          # Identifier for the last event from the previous pagination request.
          after: nil,
          # Number of events to retrieve.
          limit: nil,
          request_options: {}
        ); end
        sig { override.returns({after: String, limit: Integer, request_options: OpenAI::RequestOptions}) }
        def to_hash; end
      end
    end
  end
end
