# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # A built-in voice available for Live speech.
      module BuiltInVoice
        extend OpenAI::Internal::Type::Enum

        ALLOY = :alloy
        ASH = :ash
        BALLAD = :ballad
        BEACON = :beacon
        BOSSA = :bossa
        CEDAR = :cedar
        CINDER = :cinder
        CORAL = :coral
        DELTA = :delta
        ECHO = :echo
        GLEAM = :gleam
        MARIN = :marin
        MERIDIAN = :meridian
        QUARTZ = :quartz
        RIPPLE = :ripple
        SAGE = :sage
        SHIMMER = :shimmer
        STONE = :stone
        TEMPO = :tempo
        VERSE = :verse
        VESPER = :vesper
        WILLOW = :willow

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
