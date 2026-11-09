# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceDeleted < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceDeleted,
            OpenAI::Internal::AnyHash
          )
        end

        # The voice identifier.
        sig { returns(String) }
        attr_accessor :id

        # Whether the voice was deleted.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The object type, which is always `audio.voice.deleted`.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(

            id: String,

            deleted: T::Boolean,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The voice identifier.
          id:,

          # Whether the voice was deleted.
          deleted:,

          # The object type, which is always `audio.voice.deleted`.

          object: :"audio.voice.deleted"
        )
        end

        sig do
          override.returns(
            {id: String, deleted: T::Boolean, object: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
