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
          #   `cedar`. Voice cannot be changed during the session once the model has responded
          #   with audio at least once.
          #
          #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice, nil]
          optional :voice, union: -> { OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice }

          # @!method initialize(format_: nil, voice: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output} for more
          #   details.
          #
          #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The format of the output audio.
          #
          #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice] The voice the model uses to respond. Supported built-in voices are `alloy`, `ash

          # The voice the model uses to respond. Supported built-in voices are `alloy`,
          # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          # `cedar`. Voice cannot be changed during the session once the model has responded
          # with audio at least once.
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

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol) }
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
