# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RefusalDeltaBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
          sig do
            params(index: Integer, refusal: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The index of the refusal part in the message.
            index:,
            refusal: nil,
            # Always `refusal`.
            type: :refusal
          )
          end

          sig do
            override.returns({ index: Integer, type: Symbol, refusal: String })
          end
          def to_hash
          end
        end
      end
    end
  end
end
