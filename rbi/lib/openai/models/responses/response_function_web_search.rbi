# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionWebSearch < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(id: String, status: Symbol, type: Symbol).returns(T.attached_class) }
        def self.new(id:, status:, type: :web_search_call)
        end

        sig { override.returns({id: String, status: Symbol, type: Symbol}) }
        def to_hash
        end

        class Status < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          FAILED = :failed

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
