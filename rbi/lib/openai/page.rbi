# typed: strong

module OpenAI
  class Page
    include OpenAI::BasePage

    Elem = type_member

    sig { returns(T.nilable(T::Array[Elem])) }
    def data
    end

    sig { params(_: T.nilable(T::Array[Elem])).returns(T.nilable(T::Array[Elem])) }
    def data=(_)
    end

    sig { returns(String) }
    def object
    end

    sig { params(_: String).returns(String) }
    def object=(_)
    end

    sig { returns(String) }
    def inspect
    end
  end
end
