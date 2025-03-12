# typed: strong

module OpenAI
  class CursorPage
    include OpenAI::BasePage

    Elem = type_member

    sig { returns(T::Array[Elem]) }
    def data
    end

    sig { params(_: T::Array[Elem]).returns(T::Array[Elem]) }
    def data=(_)
    end

    sig { returns(T::Boolean) }
    def has_more
    end

    sig { params(_: T::Boolean).returns(T::Boolean) }
    def has_more=(_)
    end

    sig do
      params(
        client: OpenAI::BaseClient,
        req: OpenAI::BaseClient::RequestComponentsShape,
        headers: T.any(T::Hash[String, String], Net::HTTPHeader),
        page_data: T::Hash[Symbol, T.anything]
      )
        .void
    end
    def initialize(client:, req:, headers:, page_data:)
    end
  end
end
