# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDeltaBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The index of the content part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `image_url`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(OpenAI::Beta::Threads::ImageURLDelta)) }
          attr_reader :image_url

          sig do
            params(image_url: OpenAI::Beta::Threads::ImageURLDelta::OrHash).void
          end
          attr_writer :image_url

          # References an image URL in the content of a message.
          sig do
            params(
              index: Integer,
              image_url: OpenAI::Beta::Threads::ImageURLDelta::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part in the message.
            index:,
            image_url: nil,
            # Always `image_url`.
            type: :image_url
          )
          end

          sig do
            override.returns(
              {
                index: Integer,
                type: Symbol,
                image_url: OpenAI::Beta::Threads::ImageURLDelta
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
