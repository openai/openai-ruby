# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RefusalDeltaBlock < OpenAI::BaseModel
          # The index of the refusal part in the message.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Always `refusal`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(String)) }
          def refusal
          end

          sig { params(_: String).returns(String) }
          def refusal=(_)
          end

          # The refusal content that is part of a message.
          sig { params(index: Integer, refusal: String, type: Symbol).returns(T.attached_class) }
          def self.new(index:, refusal: nil, type: :refusal)
          end

          sig { override.returns({index: Integer, type: Symbol, refusal: String}) }
          def to_hash
          end
        end
      end
    end
  end
end
