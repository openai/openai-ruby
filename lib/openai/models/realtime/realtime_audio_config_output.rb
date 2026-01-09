# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfigOutput < OpenAI::Internal::Type::BaseModel
        # @!attribute format_
        #   The format of the output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
        optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

        # @!attribute speed
        #   The speed of the model's spoken response as a multiple of the original speed.
        #   1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
        #   This value can only be changed in between model turns, not while a response is
        #   in progress.
        #
        #   This parameter is a post-processing adjustment to the audio after it is
        #   generated, it's also possible to prompt the model to speak faster or slower.
        #
        #   @return [Float, nil]
        optional :speed, Float

        # @!attribute voice
        #   The voice the model uses to respond. Supported built-in voices are `alloy`,
        #   `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
        #   `cedar`. Voice cannot be changed during the session once the model has responded
        #   with audio at least once. We recommend `marin` and `cedar` for best quality.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice, nil]
        optional :voice, union: -> { OpenAI::Realtime::RealtimeAudioConfigOutput::Voice }

        # @!method initialize(format_: nil, speed: nil, voice: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeAudioConfigOutput} for more details.
        #
        #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The format of the output audio.
        #
        #   @param speed [Float] The speed of the model's spoken response as a multiple of the original speed.
        #
        #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice] The voice the model uses to respond. Supported built-in voices are `alloy`, `ash

        # The voice the model uses to respond. Supported built-in voices are `alloy`,
        # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
        # `cedar`. Voice cannot be changed during the session once the model has responded
        # with audio at least once. We recommend `marin` and `cedar` for best quality.
        #
        # @see OpenAI::Models::Realtime::RealtimeAudioConfigOutput#voice
        module Voice
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::ALLOY }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::ASH }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::BALLAD }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::CORAL }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::ECHO }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::SAGE }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::SHIMMER }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::VERSE }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::MARIN }

          variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfigOutput::Voice::CEDAR }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol) }
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
