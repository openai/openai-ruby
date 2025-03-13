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
  end
end
