# typed: strong

module OpenAI
  class Page
    include OpenAI::BasePage

    Elem = type_member

    sig { returns(T::Array[Elem]) }
    def data
    end

    sig { params(_: T::Array[Elem]).returns(T::Array[Elem]) }
    def data=(_)
    end

    sig { returns(String) }
    def object
    end

    sig { params(_: String).returns(String) }
    def object=(_)
    end

    sig do
      params(
        client: OpenAI::BaseClient,
        req: OpenAI::BaseClient::RequestComponentsShape,
        headers: T.any(T::Hash[String, String], Net::HTTPHeader),
        page_data: T::Array[T.anything]
      )
        .returns(T.attached_class)
    end
    def self.new(client:, req:, headers:, page_data:)
    end
  end
end
