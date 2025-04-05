# typed: strong

module OpenAI
  module Internal
    class Page
      include OpenAI::Internal::Type::BasePage

      Elem = type_member

      sig { returns(T.nilable(T::Array[Elem])) }
      attr_accessor :data

      sig { returns(String) }
      attr_accessor :object

      sig { returns(String) }
      def inspect; end
    end
  end
end
