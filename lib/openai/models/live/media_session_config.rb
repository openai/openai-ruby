# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class MediaSessionConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute model
        #   The Live model. Required in the session configuration for every transport; do
        #   not pass it as a URL query parameter.
        #
        #   @return [String, Symbol, OpenAI::Models::Live::MediaSessionConfig::Model]
        required :model, union: -> { OpenAI::Live::MediaSessionConfig::Model }

        # @!attribute audio
        #   Startup audio configuration. WebRTC and SIP negotiate their audio format on the
        #   media transport.
        #
        #   @return [OpenAI::Models::Live::MediaSessionConfig::Audio, nil]
        optional :audio, -> { OpenAI::Live::MediaSessionConfig::Audio }

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
        #   @return [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::MediaSessionConfig::Delegation::Responses, nil]
        optional :delegation, union: -> { OpenAI::Live::MediaSessionConfig::Delegation }, nil?: true

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

        # @!method initialize(model:, audio: nil, client: nil, delegation: nil, input: nil, instructions: nil, store: nil)
        #   Startup configuration for a Live media session. Follow the
        #   [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
        #   when writing frontend instructions and the backend prompt under
        #   delegation.responses.instructions.
        #
        #   @param model [String, Symbol, OpenAI::Models::Live::MediaSessionConfig::Model]
        #     The Live model. Required in the session configuration for every transport; do
        #     not pass it as a URL query parameter.
        #
        #   @param audio [OpenAI::Models::Live::MediaSessionConfig::Audio]
        #     Startup audio configuration. WebRTC and SIP negotiate their audio format on the
        #     media transport.
        #
        #   @param client [OpenAI::Models::Live::ClientConfig]
        #     Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #     session. Trusted sideband connections are unaffected.
        #
        #   @param delegation [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::MediaSessionConfig::Delegation::Responses, nil]
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

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        #
        # @see OpenAI::Models::Live::MediaSessionConfig#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Live::MediaSessionConfig::Model::GPT_LIVE_1 }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Live::MediaSessionConfig::Model::TaggedSymbol) }
          end

          # @!group

          GPT_LIVE_1 = :"gpt-live-1"

          # @!endgroup
        end

        # @see OpenAI::Models::Live::MediaSessionConfig#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute output
          #   Settings for speech generated by the Live model. Choose the voice before
          #   starting the session.
          #
          #   @return [OpenAI::Models::Live::MediaSessionConfig::Audio::Output, nil]
          optional :output, -> { OpenAI::Live::MediaSessionConfig::Audio::Output }

          # @!method initialize(output: nil)
          #   Startup audio configuration. WebRTC and SIP negotiate their audio format on the
          #   media transport.
          #
          #   @param output [OpenAI::Models::Live::MediaSessionConfig::Audio::Output]
          #     Settings for speech generated by the Live model. Choose the voice before
          #     starting the session.

          # @see OpenAI::Models::Live::MediaSessionConfig::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute voice
            #   The voice used for Live speech, as a built-in voice name or a custom voice
            #   object containing its ID. Defaults to `marin` and cannot change after startup.
            #
            #   @return [String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice, nil]
            optional :voice, union: -> { OpenAI::Live::MediaSessionConfig::Audio::Output::Voice }

            # @!method initialize(voice: nil)
            #   Settings for speech generated by the Live model. Choose the voice before
            #   starting the session.
            #
            #   @param voice [String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice]
            #     The voice used for Live speech, as a built-in voice name or a custom voice
            #     object containing its ID. Defaults to `marin` and cannot change after startup.

            # The voice used for Live speech, as a built-in voice name or a custom voice
            # object containing its ID. Defaults to `marin` and cannot change after startup.
            #
            # @see OpenAI::Models::Live::MediaSessionConfig::Audio::Output#voice
            module Voice
              extend OpenAI::Internal::Type::Union

              variant String

              # A built-in voice available for Live speech.
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
        # @see OpenAI::Models::Live::MediaSessionConfig#delegation
        module Delegation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Delegate tasks to your application. The Live session emits delegation events that your backend handles.
          variant :client, -> { OpenAI::Live::ClientDelegation }

          # Delegate tasks to a Responses model managed by the Live session.
          variant :responses, -> { OpenAI::Live::MediaSessionConfig::Delegation::Responses }

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
          #   @return [Array(OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::MediaSessionConfig::Delegation::Responses)]
        end
      end
    end
  end
end
