# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionResource < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the Live session. Use this ID for sideband connections,
        #   forking, and recording download.
        #
        #   @return [String]
        required :id, String

        # @!attribute expires_at
        #   The Unix timestamp, in seconds, at which the Live session expires.
        #
        #   @return [Integer]
        required :expires_at, Integer

        # @!attribute model
        #   The Live model. Required in the session configuration for every transport; do
        #   not pass it as a URL query parameter.
        #
        #   @return [String, Symbol, OpenAI::Models::Live::SessionResource::Model]
        required :model, union: -> { OpenAI::Live::SessionResource::Model }

        # @!attribute status
        #   The status of the session snapshot. Always `active`, including the final
        #   snapshot in session.closed; use the event type to determine that the session has
        #   closed.
        #
        #   @return [Symbol, :active]
        required :status, const: :active

        # @!attribute audio
        #   Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
        #   and SIP negotiate their media format. Voice and format are immutable after
        #   startup.
        #
        #   @return [OpenAI::Models::Live::SessionResource::Audio, nil]
        optional :audio, -> { OpenAI::Live::SessionResource::Audio }

        # @!attribute client
        #   Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #   session. Trusted sideband connections are unaffected.
        #
        #   @return [OpenAI::Models::Live::ClientConfig, nil]
        optional :client, -> { OpenAI::Live::ClientConfig }

        # @!attribute delegation
        #   Who handles tasks delegated by the Live model. Omitted or null selects your
        #   application; use `responses` to let the API manage a Responses backend.
        #
        #   @return [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionResource::Delegation::Responses, nil]
        optional :delegation, union: -> { OpenAI::Live::SessionResource::Delegation }, nil?: true

        # @!attribute input
        #   Ordered text-only history supplied before startup. Supports developer, user, and
        #   assistant messages with one text part each; at most 128 messages and 8,192
        #   rendered tokens in total.
        #
        #   @return [Array<OpenAI::Models::Live::InitialItem::Developer, OpenAI::Models::Live::InitialItem::User, OpenAI::Models::Live::InitialItem::Assistant>, nil]
        optional :input, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::InitialItem] }

        # @!attribute instructions
        #   Frontend instructions for voice, conversation, interruptions, and when to
        #   delegate. Start with the
        #   [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting);
        #   put business rules and tool workflows in a separate
        #   [backend prompt](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #   Limited to 16,384 client-supplied tokens. Omitted or blank instructions use
        #   server defaults. Immutable after startup.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute store
        #   Whether to store the session for later forking and recording download. Defaults
        #   to false for new sessions.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::Internal::Type::Boolean

        # @!method initialize(id:, expires_at:, model:, audio: nil, client: nil, delegation: nil, input: nil, instructions: nil, store: nil, status: :active)
        #   The resolved Live session configuration and server-assigned session metadata.
        #
        #   @param id [String]
        #     The unique ID of the Live session. Use this ID for sideband connections,
        #     forking, and recording download.
        #
        #   @param expires_at [Integer]
        #     The Unix timestamp, in seconds, at which the Live session expires.
        #
        #   @param model [String, Symbol, OpenAI::Models::Live::SessionResource::Model]
        #     The Live model. Required in the session configuration for every transport; do
        #     not pass it as a URL query parameter.
        #
        #   @param audio [OpenAI::Models::Live::SessionResource::Audio]
        #     Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
        #     and SIP negotiate their media format. Voice and format are immutable after
        #     startup.
        #
        #   @param client [OpenAI::Models::Live::ClientConfig]
        #     Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #     session. Trusted sideband connections are unaffected.
        #
        #   @param delegation [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionResource::Delegation::Responses, nil]
        #     Who handles tasks delegated by the Live model. Omitted or null selects your
        #     application; use `responses` to let the API manage a Responses backend.
        #
        #   @param input [Array<OpenAI::Models::Live::InitialItem::Developer, OpenAI::Models::Live::InitialItem::User, OpenAI::Models::Live::InitialItem::Assistant>]
        #     Ordered text-only history supplied before startup. Supports developer, user, and
        #     assistant messages with one text part each; at most 128 messages and 8,192
        #     rendered tokens in total.
        #
        #   @param instructions [String, nil]
        #     Frontend instructions for voice, conversation, interruptions, and when to
        #     delegate. Start with the
        #     [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting);
        #     put business rules and tool workflows in a separate
        #     [backend prompt](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #     Limited to 16,384 client-supplied tokens. Omitted or blank instructions use
        #     server defaults. Immutable after startup.
        #
        #   @param store [Boolean]
        #     Whether to store the session for later forking and recording download. Defaults
        #     to false for new sessions.
        #
        #   @param status [Symbol, :active]
        #     The status of the session snapshot. Always `active`, including the final
        #     snapshot in session.closed; use the event type to determine that the session has
        #     closed.

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        #
        # @see OpenAI::Models::Live::SessionResource#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Live::SessionResource::Model::GPT_LIVE_1 }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Live::SessionResource::Model::TaggedSymbol) }
          end

          # @!group

          GPT_LIVE_1 = :"gpt-live-1"

          # @!endgroup
        end

        # @see OpenAI::Models::Live::SessionResource#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   Audio encoding and sample rate for audio sent and received over a Live WebSocket
          #   connection. WebRTC and SIP negotiate their media format separately.
          #
          #   @return [OpenAI::Models::Live::AudioFormat::AudioPCM, OpenAI::Models::Live::AudioFormat::AudioPCMU, OpenAI::Models::Live::AudioFormat::AudioPCMA, nil]
          optional :format_, union: -> { OpenAI::Live::AudioFormat }, api_name: :format

          # @!attribute output
          #   The voice used for speech generated by the Live model.
          #
          #   @return [OpenAI::Models::Live::SessionResource::Audio::Output, nil]
          optional :output, -> { OpenAI::Live::SessionResource::Audio::Output }

          # @!method initialize(format_: nil, output: nil)
          #   Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
          #   and SIP negotiate their media format. Voice and format are immutable after
          #   startup.
          #
          #   @param format_ [OpenAI::Models::Live::AudioFormat::AudioPCM, OpenAI::Models::Live::AudioFormat::AudioPCMU, OpenAI::Models::Live::AudioFormat::AudioPCMA]
          #     Audio encoding and sample rate for audio sent and received over a Live WebSocket
          #     connection. WebRTC and SIP negotiate their media format separately.
          #
          #   @param output [OpenAI::Models::Live::SessionResource::Audio::Output]
          #     The voice used for speech generated by the Live model.

          # @see OpenAI::Models::Live::SessionResource::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute voice
            #   The voice used for Live speech, as a built-in voice name or a custom voice
            #   object containing its ID. Defaults to `marin` and cannot change after startup.
            #
            #   @return [String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice, nil]
            optional :voice, union: -> { OpenAI::Live::SessionResource::Audio::Output::Voice }

            # @!method initialize(voice: nil)
            #   The voice used for speech generated by the Live model.
            #
            #   @param voice [String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice]
            #     The voice used for Live speech, as a built-in voice name or a custom voice
            #     object containing its ID. Defaults to `marin` and cannot change after startup.

            # The voice used for Live speech, as a built-in voice name or a custom voice
            # object containing its ID. Defaults to `marin` and cannot change after startup.
            #
            # @see OpenAI::Models::Live::SessionResource::Audio::Output#voice
            module Voice
              extend OpenAI::Internal::Type::Union

              variant String

              # The voice used for Live speech, as a built-in voice name or a custom voice object containing its ID. Defaults to `marin` and cannot change after startup.
              variant enum: -> { OpenAI::Live::BuiltInVoice }

              variant -> { OpenAI::Live::CustomVoice }

              # @!method self.variants
              #   @return [Array(String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice)]
            end
          end
        end

        # Who handles tasks delegated by the Live model. Omitted or null selects your
        # application; use `responses` to let the API manage a Responses backend.
        #
        # @see OpenAI::Models::Live::SessionResource#delegation
        module Delegation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Delegate tasks to your application. The Live session emits delegation events that your backend handles.
          variant :client, -> { OpenAI::Live::ClientDelegation }

          # Delegate tasks to a Responses model managed by the Live session.
          variant :responses, -> { OpenAI::Live::SessionResource::Delegation::Responses }

          class Responses < OpenAI::Internal::Type::BaseModel
            # @!attribute responses
            #   Backend model, prompt, and tools used when the Live session delegates a task to
            #   Responses.
            #
            #   @return [OpenAI::Models::Live::ResponsesDelegationConfig]
            required :responses, -> { OpenAI::Live::ResponsesDelegationConfig }

            # @!attribute type
            #   The delegation owner. Always `responses` for tasks handled by the Responses API.
            #
            #   @return [Symbol, :responses]
            required :type, const: :responses

            # @!method initialize(responses:, type: :responses)
            #   Delegate tasks to a Responses model managed by the Live session.
            #
            #   @param responses [OpenAI::Models::Live::ResponsesDelegationConfig]
            #     Backend model, prompt, and tools used when the Live session delegates a task to
            #     Responses.
            #
            #   @param type [Symbol, :responses]
            #     The delegation owner. Always `responses` for tasks handled by the Responses API.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionResource::Delegation::Responses)]
        end
      end
    end
  end
end
