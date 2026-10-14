# typed: strong

module OpenAI
  module Models

    module Live

      class CustomVoice < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::CustomVoice,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        sig do
          params(

            id: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:
        )
        end

        sig do
          override.returns(
            {id: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
