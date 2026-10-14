# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentBrowserAuthenticationSubmitParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentBrowserAuthenticationSubmitParam,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(Symbol) }
        attr_accessor :action

        # Values for up to six active fields in the required action. The submitted
        # field-value mapping and selected option must fit within 120 KiB of JSON.
        sig { returns(T::Array[OpenAI::Beta::AgentBrowserAuthenticationSubmitParam::Field]) }
        attr_accessor :fields

        sig { returns(Symbol) }
        attr_accessor :type

        # The chosen method. Required when the required action contains options.
        sig { returns(T.nilable(String)) }
        attr_accessor :selected_option

        sig do
          params(

            fields: T::Array[OpenAI::Beta::AgentBrowserAuthenticationSubmitParam::Field::OrHash],

            selected_option: T.nilable(String),

            action: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Values for up to six active fields in the required action. The submitted
          # field-value mapping and selected option must fit within 120 KiB of JSON.
          fields:,

          # The chosen method. Required when the required action contains options.
          selected_option: nil,

          action: :submit,

          type: :browser_authentication
        )
        end

        sig do
          override.returns(
            {
              action: Symbol,
              fields: T::Array[OpenAI::Beta::AgentBrowserAuthenticationSubmitParam::Field],
              type: Symbol,
              selected_option: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Field < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentBrowserAuthenticationSubmitParam::Field,
              OpenAI::Internal::AnyHash
            )
          end

          # The field ID from the required action.
          sig { returns(String) }
          attr_accessor :field_id

          # The value to enter into the registered control.
          sig { returns(String) }
          attr_accessor :value

          # One user-entered value, including non-password fields such as an email address.
          sig do
            params(

              field_id: String,

              value: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The field ID from the required action.
            field_id:,

            # The value to enter into the registered control.

            value:
          )
          end

          sig do
            override.returns(
              {field_id: String, value: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
