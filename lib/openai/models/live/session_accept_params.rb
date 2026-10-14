# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#accept
      class SessionAcceptParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #
        #   @return [String]
        required :session_id, String

        # @!attribute session
        #   Model and startup configuration for the Live session that answers the incoming
        #   SIP call.
        #
        #   @return [OpenAI::Models::Live::SessionAcceptParams::Session]
        required :session, -> { OpenAI::Live::SessionAcceptParams::Session }

        # @!method initialize(session_id:, session:, request_options: {})
        #   @param session_id [String]
        #
        #   @param session [OpenAI::Models::Live::SessionAcceptParams::Session]
        #     Model and startup configuration for the Live session that answers the incoming
        #     SIP call.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class Session < OpenAI::Internal::Type::BaseModel
          # @!attribute model
          #   The Live model to use for the accepted call.
          #
          #   @return [String, Symbol, OpenAI::Models::Live::SessionAcceptParams::Session::Model]
          required :model, union: -> { OpenAI::Live::SessionAcceptParams::Session::Model }

          # @!attribute type
          #   The session type. Always `live`.
          #
          #   @return [Symbol, :live]
          required :type, const: :live

          # @!attribute audio
          #   Startup audio output configuration. SIP negotiates the media format;
          #   audio.format is only accepted for primary WebSockets. Voice cannot change after
          #   startup.
          #
          #   @return [OpenAI::Models::Live::SessionAcceptParams::Session::Audio, nil]
          optional :audio, -> { OpenAI::Live::SessionAcceptParams::Session::Audio }

          # @!attribute delegation
          #   Who handles tasks delegated by the Live model. Omitted or null selects your
          #   application; use `responses` to let the API manage a Responses backend.
          #
          #   @return [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionAcceptParams::Session::Delegation::Responses, nil]
          optional(
            :delegation,
            union: -> {
              OpenAI::Live::SessionAcceptParams::Session::Delegation
            },
            nil?: true
          )

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

          # @!method initialize(model:, audio: nil, delegation: nil, input: nil, instructions: nil, store: nil, type: :live)
          #   Model and startup configuration for the Live session that answers the incoming
          #   SIP call.
          #
          #   @param model [String, Symbol, OpenAI::Models::Live::SessionAcceptParams::Session::Model]
          #     The Live model to use for the accepted call.
          #
          #   @param audio [OpenAI::Models::Live::SessionAcceptParams::Session::Audio]
          #     Startup audio output configuration. SIP negotiates the media format;
          #     audio.format is only accepted for primary WebSockets. Voice cannot change after
          #     startup.
          #
          #   @param delegation [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionAcceptParams::Session::Delegation::Responses, nil]
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
          #   @param type [Symbol, :live]
          #     The session type. Always `live`.

          # The Live model to use for the accepted call.
          #
          # @see OpenAI::Models::Live::SessionAcceptParams::Session#model
          module Model
            extend OpenAI::Internal::Type::Union

            variant String

            # The Live model. Required in the session configuration for every transport; do not pass it as a URL query parameter.
            variant const: -> { OpenAI::Models::Live::SessionAcceptParams::Session::Model::GPT_LIVE_1 }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Live::SessionAcceptParams::Session::Model::TaggedSymbol) }
            end

            # @!group

            GPT_LIVE_1 = :"gpt-live-1"

            # @!endgroup
          end

          # @see OpenAI::Models::Live::SessionAcceptParams::Session#audio
          class Audio < OpenAI::Internal::Type::BaseModel
            # @!attribute output
            #   Settings for speech generated by the Live model. Choose the voice before
            #   starting the session.
            #
            #   @return [OpenAI::Models::Live::SessionAcceptParams::Session::Audio::Output, nil]
            optional :output, -> { OpenAI::Live::SessionAcceptParams::Session::Audio::Output }

            # @!method initialize(output: nil)
            #   Startup audio output configuration. SIP negotiates the media format;
            #   audio.format is only accepted for primary WebSockets. Voice cannot change after
            #   startup.
            #
            #   @param output [OpenAI::Models::Live::SessionAcceptParams::Session::Audio::Output]
            #     Settings for speech generated by the Live model. Choose the voice before
            #     starting the session.

            # @see OpenAI::Models::Live::SessionAcceptParams::Session::Audio#output
            class Output < OpenAI::Internal::Type::BaseModel
              # @!attribute voice
              #   The voice used for Live speech, as a built-in voice name or a custom voice
              #   object containing its ID. Defaults to `marin` and cannot change after startup.
              #
              #   @return [String, Symbol, OpenAI::Models::Live::BuiltInVoice, OpenAI::Models::Live::CustomVoice, nil]
              optional :voice, union: -> { OpenAI::Live::SessionAcceptParams::Session::Audio::Output::Voice }

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
              # @see OpenAI::Models::Live::SessionAcceptParams::Session::Audio::Output#voice
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
          # @see OpenAI::Models::Live::SessionAcceptParams::Session#delegation
          module Delegation
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Delegate tasks to your application. The Live session emits delegation events that your backend handles.
            variant :client, -> { OpenAI::Live::ClientDelegation }

            # Delegate tasks to a Responses model managed by the Live session.
            variant :responses, -> { OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses }

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
            #   @return [Array(OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionAcceptParams::Session::Delegation::Responses)]
          end
        end
      end
    end
  end
end
