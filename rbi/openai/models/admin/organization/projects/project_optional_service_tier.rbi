# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        ProjectOptionalServiceTier = Projects::ProjectOptionalServiceTier

        module Projects

          module ProjectOptionalServiceTier
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FLEX = T.let(:flex, OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::TaggedSymbol)
            FAST = T.let(:fast, OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::TaggedSymbol)
            ULTRAFAST = T.let(
              :ultrafast,
              OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Admin::Organization::Projects::ProjectOptionalServiceTier::TaggedSymbol]
              )
            }
            def self.values
            end
          end

        end

      end

    end

  end
end
