# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseCreateAudioOutput < OpenAI::Internal::Type::BaseModel
        # @!attribute output
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output, nil]
        optional :output, -> { OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output }

        # @!method initialize(output: nil)
        #   Configuration for audio input and output.
        #
        #   @param output [OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output]

        # @see OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput#output
        class Output < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   The format of the output audio.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
          optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

          # @!attribute voice
          #   The voice the model uses to respond. Supported built-in voices are `alloy`,
          #   `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          #   `cedar`. You may also provide a custom voice object with an `id`, for example
          #   `{ "id": "voice_1234" }`. Voice cannot be changed during the session once the
          #   model has responded with audio at least once. We recommend `marin` and `cedar`
          #   for best quality.
          #
          #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice, nil]
          optional :voice, union: -> { OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice }

          # @!method initialize(format_: nil, voice: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output} for more
          #   details.
          #
          #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The format of the output audio.
          #
          #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice] The voice the model uses to respond. Supported built-in voices are

          # The voice the model uses to respond. Supported built-in voices are `alloy`,
          # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          # `cedar`. You may also provide a custom voice object with an `id`, for example
          # `{ "id": "voice_1234" }`. Voice cannot be changed during the session once the
          # model has responded with audio at least once. We recommend `marin` and `cedar`
          # for best quality.
          #
          # @see OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output#voice
          module Voice
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ALLOY }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ASH }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::BALLAD }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::CORAL }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ECHO }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::SAGE }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::SHIMMER }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::VERSE }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::MARIN }

            variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::CEDAR }

            # Custom voice reference.
            variant -> { OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID }

            class ID < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The custom voice ID, e.g. `voice_1234`.
              #
              #   @return [String]
              required :id, String

              # @!method initialize(id:)
              #   Custom voice reference.
              #
              #   @param id [String] The custom voice ID, e.g. `voice_1234`.
            end

            # @!method self.variants
            #   @return [Array(String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID)]

            define_sorbet_constant!(:Variants) do
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID
                )
              end
            end

            # @!group

            ALLOY = :alloy
            ASH = :ash
            BALLAD = :ballad
            CORAL = :coral
            ECHO = :echo
            SAGE = :sage
            SHIMMER = :shimmer
            VERSE = :verse
            MARIN = :marin
            CEDAR = :cedar

            # @!endgroup
          end
        end
      end
    end
  end
end
