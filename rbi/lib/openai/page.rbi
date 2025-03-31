# typed: strong

module OpenAI
  class Page
    include OpenAI::Type::BasePage

    Elem = type_member

    sig { returns(T.nilable(T::Array[Elem])) }
    attr_accessor :data

    sig { returns(String) }
    attr_accessor :object

    sig { returns(String) }
    def inspect
    end
  end
end
