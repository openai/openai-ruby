# typed: strong

module OpenAI
  module Models
    module Beta
      # Controls which (if any) tool is called by the model. `none` means the model will
      #   not call any tools and instead generates a message. `auto` is the default value
      #   and means the model can pick between generating a message or calling one or more
      #   tools. `required` means the model must call one or more tools before responding
      #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
      #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
      #   call that tool.
      class AssistantToolChoiceOption < OpenAI::Union
        abstract!

        # `none` means the model will not call any tools and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools before
        #   responding to the user.
        class Auto < OpenAI::Enum
          abstract!

          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class << self
          sig { override.returns([Symbol, OpenAI::Models::Beta::AssistantToolChoice]) }
          def variants
          end
        end
      end
    end
  end
end
