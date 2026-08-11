# typed: strict
# frozen_string_literal: true

require "openai"

return unless defined?(OpenAI::BaseModel)

module Tapioca
  module Dsl
    module Compilers
      # Generates RBI definitions for application-defined structured output models.
      class OpenAIBaseModel < Compiler
        extend T::Sig

        ConstantType = type_member { {fixed: T.class_of(::OpenAI::BaseModel)} }

        sig { override.void }
        def decorate
          root.create_path(constant) do |model|
            constant.fields.each do |name, field|
              type = ::OpenAI::Internal::Util::SorbetRuntimeSupport.to_sorbet_type(field.fetch(:type)).to_s
              type = as_nilable_type(type) if field.fetch(:nilable) || !field.fetch(:required)
              model.create_method(name.to_s, return_type: type)
            end
          end
        end

        class << self
          extend T::Sig

          sig { override.returns(T::Enumerable[Module]) }
          def gather_constants
            all_classes.select { _1 < ::OpenAI::BaseModel }
          end
        end
      end
    end
  end
end
