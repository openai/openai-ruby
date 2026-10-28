# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalKeys#list
        class ExternalKeyListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #
          #   @return [String, nil]
          optional :after, String, nil?: true

          # @!attribute limit
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::ExternalKeyListParams::Order }

          # @!attribute purpose
          #   Filter by key purpose. When omitted, returns keys of all purposes.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Purpose, nil]
          optional :purpose, enum: -> { OpenAI::Admin::Organization::ExternalKeyListParams::Purpose }

          # @!method initialize(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
          #   @param after [String, nil]
          #
          #   @param limit [Integer]
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Order]
          #
          #   @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Purpose]
          #     Filter by key purpose. When omitted, returns keys of all purposes.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Filter by key purpose. When omitted, returns keys of all purposes.
          module Purpose
            extend OpenAI::Internal::Type::Enum

            EKM = :ekm
            PSP_DECRYPTION = :psp_decryption

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
