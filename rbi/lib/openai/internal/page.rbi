# typed: strong

module OpenAI
  module Internal
    class Page
      Elem = type_member

      include OpenAI::Internal::Type::BasePage

      sig { returns(T.nilable(T::Array[Elem])) }
      attr_accessor :data

      sig { returns(String) }
      attr_accessor :object

      sig { returns(String) }
      def inspect
      end
    end
  end
end
