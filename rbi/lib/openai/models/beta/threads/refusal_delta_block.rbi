# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RefusalDeltaBlock < OpenAI::Internal::Type::BaseModel
          # The index of the refusal part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `refusal`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :refusal

          sig { params(refusal: String).void }
          attr_writer :refusal

          # The refusal content that is part of a message.
          sig { params(index: Integer, refusal: String, type: Symbol).returns(T.attached_class) }
          def self.new(index:, refusal: nil, type: :refusal); end

          sig { override.returns({index: Integer, type: Symbol, refusal: String}) }
          def to_hash; end
        end
      end
    end
  end
end
