# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module ProjectResidency
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::ProjectResidency) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GLOBAL = T.let(:GLOBAL, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          US_STORAGE_PROCESSING = T.let(
            :US_STORAGE_PROCESSING,
            OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol
          )
          EU_STORAGE_PROCESSING = T.let(
            :EU_STORAGE_PROCESSING,
            OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol
          )
          JP_STORAGE = T.let(:JP_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          KR_STORAGE = T.let(:KR_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          CA_STORAGE = T.let(:CA_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          SG_STORAGE = T.let(:SG_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          IN_STORAGE = T.let(:IN_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          AU_STORAGE = T.let(:AU_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          GB_STORAGE = T.let(:GB_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          AE_STORAGE = T.let(:AE_STORAGE, OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol)
          AE_STORAGE_PROCESSING = T.let(
            :AE_STORAGE_PROCESSING,
            OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol
          )

          sig { override.returns(T::Array[OpenAI::Admin::Organization::ProjectResidency::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
