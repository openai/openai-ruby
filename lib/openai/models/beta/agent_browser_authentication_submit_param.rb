# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentBrowserAuthenticationSubmitParam < OpenAI::Internal::Type::BaseModel
        # @!attribute action
        #
        #   @return [Symbol, :submit]
        required :action, const: :submit

        # @!attribute fields
        #   Values for up to six active fields in the required action. The submitted
        #   field-value mapping and selected option must fit within 120 KiB of JSON.
        #
        #   @return [Array<OpenAI::Models::Beta::AgentBrowserAuthenticationSubmitParam::Field>]
        required(
          :fields,
          -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::AgentBrowserAuthenticationSubmitParam::Field] }
        )

        # @!attribute type
        #
        #   @return [Symbol, :browser_authentication]
        required :type, const: :browser_authentication

        # @!attribute selected_option
        #   The chosen method. Required when the required action contains options.
        #
        #   @return [String, nil]
        optional :selected_option, String, nil?: true

        # @!method initialize(fields:, selected_option: nil, action: :submit, type: :browser_authentication)
        #   @param fields [Array<OpenAI::Models::Beta::AgentBrowserAuthenticationSubmitParam::Field>]
        #     Values for up to six active fields in the required action. The submitted
        #     field-value mapping and selected option must fit within 120 KiB of JSON.
        #
        #   @param selected_option [String, nil]
        #     The chosen method. Required when the required action contains options.
        #
        #   @param action [Symbol, :submit]
        #
        #   @param type [Symbol, :browser_authentication]

        class Field < OpenAI::Internal::Type::BaseModel
          # @!attribute field_id
          #   The field ID from the required action.
          #
          #   @return [String]
          required :field_id, String

          # @!attribute value
          #   The value to enter into the registered control.
          #
          #   @return [String]
          required :value, String

          # @!method initialize(field_id:, value:)
          #   One user-entered value, including non-password fields such as an email address.
          #
          #   @param field_id [String]
          #     The field ID from the required action.
          #
          #   @param value [String]
          #     The value to enter into the registered control.
        end
      end
    end
  end
end
