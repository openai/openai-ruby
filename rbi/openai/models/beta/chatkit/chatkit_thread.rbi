# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitThread = ChatKit::ChatKitThread

      module ChatKit
        class ChatKitThread < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitThread,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the thread.
          sig { returns(String) }
          attr_accessor :id

          # Unix timestamp (in seconds) for when the thread was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Type discriminator that is always `chatkit.thread`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Current status for the thread. Defaults to `active` for newly created threads.
          sig do
            returns(OpenAI::Beta::ChatKit::ChatKitThread::Status::Variants)
          end
          attr_accessor :status

          # Optional human-readable title for the thread. Defaults to null when no title has
          # been generated.
          sig { returns(T.nilable(String)) }
          attr_accessor :title

          # Free-form string that identifies your end user who owns the thread.
          sig { returns(String) }
          attr_accessor :user

          # Represents a ChatKit thread and its current status.
          sig do
            params(
              id: String,
              created_at: Integer,
              status:
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Active::OrHash,
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Locked::OrHash,
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Closed::OrHash
                ),
              title: T.nilable(String),
              user: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier of the thread.
            id:,
            # Unix timestamp (in seconds) for when the thread was created.
            created_at:,
            # Current status for the thread. Defaults to `active` for newly created threads.
            status:,
            # Optional human-readable title for the thread. Defaults to null when no title has
            # been generated.
            title:,
            # Free-form string that identifies your end user who owns the thread.
            user:,
            # Type discriminator that is always `chatkit.thread`.
            object: :"chatkit.thread"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                object: Symbol,
                status: OpenAI::Beta::ChatKit::ChatKitThread::Status::Variants,
                title: T.nilable(String),
                user: String
              }
            )
          end
          def to_hash
          end

          # Current status for the thread. Defaults to `active` for newly created threads.
          module Status
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Active,
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Locked,
                  OpenAI::Beta::ChatKit::ChatKitThread::Status::Closed
                )
              end

            class Active < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThread::Status::Active,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Status discriminator that is always `active`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Indicates that a thread is active.
              sig { params(type: Symbol).returns(T.attached_class) }
              def self.new(
                # Status discriminator that is always `active`.
                type: :active
              )
              end

              sig { override.returns({ type: Symbol }) }
              def to_hash
              end
            end

            class Locked < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThread::Status::Locked,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Reason that the thread was locked. Defaults to null when no reason is recorded.
              sig { returns(T.nilable(String)) }
              attr_accessor :reason

              # Status discriminator that is always `locked`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Indicates that a thread is locked and cannot accept new input.
              sig do
                params(reason: T.nilable(String), type: Symbol).returns(
                  T.attached_class
                )
              end
              def self.new(
                # Reason that the thread was locked. Defaults to null when no reason is recorded.
                reason:,
                # Status discriminator that is always `locked`.
                type: :locked
              )
              end

              sig do
                override.returns({ reason: T.nilable(String), type: Symbol })
              end
              def to_hash
              end
            end

            class Closed < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThread::Status::Closed,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Reason that the thread was closed. Defaults to null when no reason is recorded.
              sig { returns(T.nilable(String)) }
              attr_accessor :reason

              # Status discriminator that is always `closed`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Indicates that a thread has been closed.
              sig do
                params(reason: T.nilable(String), type: Symbol).returns(
                  T.attached_class
                )
              end
              def self.new(
                # Reason that the thread was closed. Defaults to null when no reason is recorded.
                reason:,
                # Status discriminator that is always `closed`.
                type: :closed
              )
              end

              sig do
                override.returns({ reason: T.nilable(String), type: Symbol })
              end
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[OpenAI::Beta::ChatKit::ChatKitThread::Status::Variants]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
