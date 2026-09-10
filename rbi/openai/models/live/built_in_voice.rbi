# typed: strong

module OpenAI
  module Models

    module Live

      # A built-in voice available for Live speech.
      module BuiltInVoice
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::BuiltInVoice) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        ALLOY = T.let(:alloy, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        ASH = T.let(:ash, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        BALLAD = T.let(:ballad, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        BEACON = T.let(:beacon, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        BOSSA = T.let(:bossa, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        CEDAR = T.let(:cedar, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        CINDER = T.let(:cinder, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        CORAL = T.let(:coral, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        DELTA = T.let(:delta, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        ECHO = T.let(:echo, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        GLEAM = T.let(:gleam, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        MARIN = T.let(:marin, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        MERIDIAN = T.let(:meridian, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        QUARTZ = T.let(:quartz, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        RIPPLE = T.let(:ripple, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        SAGE = T.let(:sage, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        SHIMMER = T.let(:shimmer, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        STONE = T.let(:stone, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        TEMPO = T.let(:tempo, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        VERSE = T.let(:verse, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        VESPER = T.let(:vesper, OpenAI::Live::BuiltInVoice::TaggedSymbol)
        WILLOW = T.let(:willow, OpenAI::Live::BuiltInVoice::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Live::BuiltInVoice::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
