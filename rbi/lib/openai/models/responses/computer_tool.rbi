# typed: strong

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::BaseModel
        sig { returns(Float) }
        def display_height
        end

        sig { params(_: Float).returns(Float) }
        def display_height=(_)
        end

        sig { returns(Float) }
        def display_width
        end

        sig { params(_: Float).returns(Float) }
        def display_width=(_)
        end

        sig { returns(Symbol) }
        def environment
        end

        sig { params(_: Symbol).returns(Symbol) }
        def environment=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(display_height: Float, display_width: Float, environment: Symbol, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(display_height:, display_width:, environment:, type: :computer_use_preview)
        end

        sig do
          override.returns({display_height: Float, display_width: Float, environment: Symbol, type: Symbol})
        end
        def to_hash
        end

        class Environment < OpenAI::Enum
          abstract!

          MAC = :mac
          WINDOWS = :windows
          UBUNTU = :ubuntu
          BROWSER = :browser

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
