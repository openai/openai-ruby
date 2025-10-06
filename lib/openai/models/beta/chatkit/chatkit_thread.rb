# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        # @see OpenAI::Resources::Beta::ChatKit::Threads#retrieve
        class ChatKitThread < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the thread.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   Unix timestamp (in seconds) for when the thread was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute object
          #   Type discriminator that is always `chatkit.thread`.
          #
          #   @return [Symbol, :"chatkit.thread"]
          required :object, const: :"chatkit.thread"

          # @!attribute status
          #   Current status for the thread. Defaults to `active` for newly created threads.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Active, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Locked, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Closed]
          required :status, union: -> { OpenAI::Beta::ChatKit::ChatKitThread::Status }

          # @!attribute title
          #   Optional human-readable title for the thread. Defaults to null when no title has
          #   been generated.
          #
          #   @return [String, nil]
          required :title, String, nil?: true

          # @!attribute user
          #   Free-form string that identifies your end user who owns the thread.
          #
          #   @return [String]
          required :user, String

          # @!method initialize(id:, created_at:, status:, title:, user:, object: :"chatkit.thread")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::ChatKitThread} for more details.
          #
          #   Represents a ChatKit thread and its current status.
          #
          #   @param id [String] Identifier of the thread.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) for when the thread was created.
          #
          #   @param status [OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Active, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Locked, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Closed] Current status for the thread. Defaults to `active` for newly created threads.
          #
          #   @param title [String, nil] Optional human-readable title for the thread. Defaults to null when no title has
          #
          #   @param user [String] Free-form string that identifies your end user who owns the thread.
          #
          #   @param object [Symbol, :"chatkit.thread"] Type discriminator that is always `chatkit.thread`.

          # Current status for the thread. Defaults to `active` for newly created threads.
          #
          # @see OpenAI::Models::Beta::ChatKit::ChatKitThread#status
          module Status
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Indicates that a thread is active.
            variant :active, -> { OpenAI::Beta::ChatKit::ChatKitThread::Status::Active }

            # Indicates that a thread is locked and cannot accept new input.
            variant :locked, -> { OpenAI::Beta::ChatKit::ChatKitThread::Status::Locked }

            # Indicates that a thread has been closed.
            variant :closed, -> { OpenAI::Beta::ChatKit::ChatKitThread::Status::Closed }

            class Active < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   Status discriminator that is always `active`.
              #
              #   @return [Symbol, :active]
              required :type, const: :active

              # @!method initialize(type: :active)
              #   Indicates that a thread is active.
              #
              #   @param type [Symbol, :active] Status discriminator that is always `active`.
            end

            class Locked < OpenAI::Internal::Type::BaseModel
              # @!attribute reason
              #   Reason that the thread was locked. Defaults to null when no reason is recorded.
              #
              #   @return [String, nil]
              required :reason, String, nil?: true

              # @!attribute type
              #   Status discriminator that is always `locked`.
              #
              #   @return [Symbol, :locked]
              required :type, const: :locked

              # @!method initialize(reason:, type: :locked)
              #   Indicates that a thread is locked and cannot accept new input.
              #
              #   @param reason [String, nil] Reason that the thread was locked. Defaults to null when no reason is recorded.
              #
              #   @param type [Symbol, :locked] Status discriminator that is always `locked`.
            end

            class Closed < OpenAI::Internal::Type::BaseModel
              # @!attribute reason
              #   Reason that the thread was closed. Defaults to null when no reason is recorded.
              #
              #   @return [String, nil]
              required :reason, String, nil?: true

              # @!attribute type
              #   Status discriminator that is always `closed`.
              #
              #   @return [Symbol, :closed]
              required :type, const: :closed

              # @!method initialize(reason:, type: :closed)
              #   Indicates that a thread has been closed.
              #
              #   @param reason [String, nil] Reason that the thread was closed. Defaults to null when no reason is recorded.
              #
              #   @param type [Symbol, :closed] Status discriminator that is always `closed`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Active, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Locked, OpenAI::Models::Beta::ChatKit::ChatKitThread::Status::Closed)]
          end
        end
      end

      ChatKitThread = ChatKit::ChatKitThread
    end
  end
end
