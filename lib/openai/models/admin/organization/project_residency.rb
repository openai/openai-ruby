# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module ProjectResidency
          extend OpenAI::Internal::Type::Enum

          GLOBAL = :GLOBAL
          US_STORAGE_PROCESSING = :US_STORAGE_PROCESSING
          EU_STORAGE_PROCESSING = :EU_STORAGE_PROCESSING
          JP_STORAGE = :JP_STORAGE
          KR_STORAGE = :KR_STORAGE
          CA_STORAGE = :CA_STORAGE
          SG_STORAGE = :SG_STORAGE
          IN_STORAGE = :IN_STORAGE
          AU_STORAGE = :AU_STORAGE
          GB_STORAGE = :GB_STORAGE
          AE_STORAGE = :AE_STORAGE
          AE_STORAGE_PROCESSING = :AE_STORAGE_PROCESSING

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
