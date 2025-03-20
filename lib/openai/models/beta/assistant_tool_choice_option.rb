# frozen_string_literal: true

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
      module AssistantToolChoiceOption
        extend OpenAI::Union

        # `none` means the model will not call any tools and instead generates a message. `auto` means the model can pick between generating a message or calling one or more tools. `required` means the model must call one or more tools before responding to the user.
        variant enum: -> { OpenAI::Models::Beta::AssistantToolChoiceOption::Auto }

        # Specifies a tool the model should use. Use to force the model to call a specific tool.
        variant -> { OpenAI::Models::Beta::AssistantToolChoice }

        # `none` means the model will not call any tools and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools before
        #   responding to the user.
        module Auto
          extend OpenAI::Enum

          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end

        # @!parse
        #   class << self
        #     # @return [Array(Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice)]
        #     def variants; end
        #   end
      end
    end
  end
end
