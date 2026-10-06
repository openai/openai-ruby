# typed: strong

module OpenAI
  module Models

    module Live

      class ResponsesDelegationConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ResponsesDelegationConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # The model used for server-owned Responses delegations.
        sig { returns(String) }
        attr_accessor :model

        # Instructions for the delegated Responses model, separate from Live instructions.
        # See
        # [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Maximum number of output tokens for each delegated response.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_output_tokens

        # Whether the delegated Responses model may request multiple tool calls in a
        # single response.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :parallel_tool_calls

        # Reasoning settings passed to each delegated Responses request.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::OrHash)).void }
        attr_writer :reasoning

        # Service tier for delegated Responses requests.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::ServiceTier::OrSymbol)) }
        attr_accessor :service_tier

        # Text generation settings passed to each delegated Responses request.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text)) }
        attr_reader :text

        sig { params(text: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text::OrHash)).void }
        attr_writer :text

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        sig {
          returns(
            T.nilable(
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
                T::Hash[Symbol, T.anything]
              )
            )
          )
        }
        attr_reader :tool_choice

        sig {
          params(
            tool_choice: T.any(
              OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
              T::Hash[Symbol, T.anything]
            )
          )
            .void
        }
        attr_writer :tool_choice

        # Tools available to the Responses backend while it handles tasks delegated by the
        # Live model.
        sig {
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Live::FunctionTool,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Shell,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Custom,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Computer,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch
                )
              ]
            )
          )
        }
        attr_reader :tools

        sig {
          params(
            tools: T::Array[
              T.any(
                OpenAI::Live::FunctionTool::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Custom::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Computer::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch::OrHash
              )
            ]
          )
            .void
        }
        attr_writer :tools

        # Model, prompt, and tool settings for tasks delegated by the Live session to a
        # Responses backend.
        sig do
          params(

            model: String,

            instructions: T.nilable(String),

            max_output_tokens: T.nilable(Integer),

            parallel_tool_calls: T.nilable(T::Boolean),

            reasoning: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::OrHash),

            service_tier: T.nilable(OpenAI::Live::ResponsesDelegationConfig::ServiceTier::OrSymbol),

            text: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text::OrHash),

            tool_choice: T.any(
              OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
              T::Hash[Symbol, T.anything]
            ),

            tools: T::Array[
              T.any(
                OpenAI::Live::FunctionTool::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Custom::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::Computer::OrHash,
                OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch::OrHash
              )
            ]
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The model used for server-owned Responses delegations.
          model:,

          # Instructions for the delegated Responses model, separate from Live instructions.
          # See
          # [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
          instructions: nil,

          # Maximum number of output tokens for each delegated response.
          max_output_tokens: nil,

          # Whether the delegated Responses model may request multiple tool calls in a
          # single response.
          parallel_tool_calls: nil,

          # Reasoning settings passed to each delegated Responses request.
          reasoning: nil,

          # Service tier for delegated Responses requests.
          service_tier: nil,

          # Text generation settings passed to each delegated Responses request.
          text: nil,

          # Controls which tool the Responses backend uses when handling a task delegated by
          # the Live model.
          tool_choice: nil,

          # Tools available to the Responses backend while it handles tasks delegated by the
          # Live model.

          tools: nil
        )
        end

        sig do
          override.returns(
            {
              model: String,
              instructions: T.nilable(String),
              max_output_tokens: T.nilable(Integer),
              parallel_tool_calls: T.nilable(T::Boolean),
              reasoning: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning),
              service_tier: T.nilable(OpenAI::Live::ResponsesDelegationConfig::ServiceTier::OrSymbol),
              text: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text),
              tool_choice: T.any(
                OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
                T::Hash[Symbol, T.anything]
              ),
              tools: T::Array[
                T.any(
                  OpenAI::Live::FunctionTool,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Shell,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Custom,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Computer,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch
                )
              ]
            }
          )
        end
        def to_hash
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ResponsesDelegationConfig::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::OrSymbol)) }
          attr_accessor :effort

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::OrSymbol)) }
          attr_accessor :summary

          # Reasoning settings passed to each delegated Responses request.
          sig do
            params(

              effort: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::OrSymbol),

              summary: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # How much reasoning effort the delegated Responses model should use. Supported
            # values depend on the backend model.
            effort: nil,

            # The reasoning summary to request from the delegated Responses model, when
            # supported.

            summary: nil
          )
          end

          sig do
            override.returns(
              {
                effort: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::OrSymbol),
                summary: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::OrSymbol)
              }
            )
          end
          def to_hash
          end

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE = T.let(:none, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)
            MINIMAL = T.let(:minimal, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)
            XHIGH = T.let(:xhigh, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort::TaggedSymbol])
            }
            def self.values
            end
          end

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          module Summary
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CONCISE = T.let(:concise, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::TaggedSymbol)
            DETAILED = T.let(:detailed, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::TaggedSymbol)
            AUTO = T.let(:auto, OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary::TaggedSymbol])
            }
            def self.values
            end
          end
        end

        # Service tier for delegated Responses requests.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::ResponsesDelegationConfig::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol)
          FAST_TIER_TEMP_PILOT = T.let(
            :fast_tier_temp_pilot,
            OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol
          )
          FLEX = T.let(:flex, OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol)
          PRIORITY = T.let(:priority, OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol)
          ULTRAFAST = T.let(:ultrafast, OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::ServiceTier::TaggedSymbol]) }
          def self.values
          end
        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ResponsesDelegationConfig::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::OrSymbol)) }
          attr_accessor :verbosity

          # Text generation settings passed to each delegated Responses request.
          sig do
            params(

              verbosity: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The amount of detail in text generated by the Responses backend. This does not
            # configure the Live model’s spoken delivery.

            verbosity: nil
          )
          end

          sig do
            override.returns(
              {verbosity: T.nilable(OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::OrSymbol)}
            )
          end
          def to_hash
          end

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW = T.let(:low, OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity::TaggedSymbol]) }
            def self.values
            end
          end
        end

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol,
              T::Hash[Symbol, T.anything]
            )
          }

          # Controls which tool the Responses backend uses when handling a task delegated by
          # the Live model.
          module LiveToolChoiceEnum
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(:auto, OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol)
            NONE = T.let(:none, OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol)
            REQUIRED = T.let(
              :required,
              OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol]
              )
            }
            def self.values
            end
          end

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::ToolChoice::Variants]) }
          def self.variants
          end

          UnionMember1Map = T.let(
            OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
            OpenAI::Internal::Type::Converter
          )

        end

        # A function tool available to the Responses backend when the Live model delegates
        # a task.
        module Tool
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::FunctionTool,
              OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch,
              OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch,
              OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter,
              OpenAI::Live::ResponsesDelegationConfig::Tool::Shell,
              OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration,
              OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp,
              OpenAI::Live::ResponsesDelegationConfig::Tool::Custom,
              OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace,
              OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch,
              OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling,
              OpenAI::Live::ResponsesDelegationConfig::Tool::Computer,
              OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch
            )
          }

          class WebSearch < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch,
                OpenAI::Internal::AnyHash
              )
            end

            # The tool type. Always `web_search`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A web search tool available to the Live session’s Responses backend.
            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The tool type. Always `web_search`.

              type: :web_search
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :file_search
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :code_interpreter
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Shell < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::Shell,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto,
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference,
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local
                  )
                )
              )
            }
            attr_accessor :environment

            # A Responses shell tool. Use a hosted container or return local shell results
            # with response.item.create. Domain secrets are not supported.
            sig do
              params(

                environment: T.nilable(
                  T.any(
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::OrHash,
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference::OrHash,
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::OrHash
                  )
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              environment: nil,

              type: :shell
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  environment: T.nilable(
                    T.any(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto,
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference,
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local
                    )
                  )
                }
              )
            end
            def to_hash
            end

            module Environment
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference,
                  OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local
                )
              }

              class ContainerAuto < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Automatically creates a container for this request
                sig { returns(Symbol) }
                attr_accessor :type

                # An optional list of uploaded files to make available to your code.
                sig { returns(T.nilable(T::Array[String])) }
                attr_accessor :file_ids

                # The memory limit for the container.
                sig {
                  returns(
                    T.nilable(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::OrSymbol
                    )
                  )
                }
                attr_accessor :memory_limit

                # Network access policy for the container.
                sig {
                  returns(
                    T.nilable(
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled,
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist
                      )
                    )
                  )
                }
                attr_accessor :network_policy

                # An optional list of skills referenced by id or inline data.
                sig {
                  returns(
                    T.nilable(
                      T::Array[
                        T.any(
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference,
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline
                        )
                      ]
                    )
                  )
                }
                attr_accessor :skills

                sig do
                  params(

                    file_ids: T.nilable(T::Array[String]),

                    memory_limit: T.nilable(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::OrSymbol
                    ),

                    network_policy: T.nilable(
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled::OrHash,
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist::OrHash
                      )
                    ),

                    skills: T.nilable(
                      T::Array[
                        T.any(
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference::OrHash,
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::OrHash
                        )
                      ]
                    ),

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # An optional list of uploaded files to make available to your code.
                  file_ids: nil,

                  # The memory limit for the container.
                  memory_limit: nil,

                  # Network access policy for the container.
                  network_policy: nil,

                  # An optional list of skills referenced by id or inline data.
                  skills: nil,

                  # Automatically creates a container for this request

                  type: :container_auto
                )
                end

                sig do
                  override.returns(
                    {
                      type: Symbol,
                      file_ids: T.nilable(T::Array[String]),
                      memory_limit: T.nilable(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::OrSymbol
                      ),
                      network_policy: T.nilable(
                        T.any(
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled,
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist
                        )
                      ),
                      skills: T.nilable(
                        T::Array[
                          T.any(
                            OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference,
                            OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline
                          )
                        ]
                      )
                    }
                  )
                end
                def to_hash
                end

                # The memory limit for the container.
                module MemoryLimit
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol = T.type_alias {
                    T.all(
                      Symbol,
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit
                    )
                  }
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  MEMORY_LIMIT_1G = T.let(
                    :"1g",
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::TaggedSymbol
                  )
                  MEMORY_LIMIT_4G = T.let(
                    :"4g",
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::TaggedSymbol
                  )
                  MEMORY_LIMIT_16G = T.let(
                    :"16g",
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::TaggedSymbol
                  )
                  MEMORY_LIMIT_64G = T.let(
                    :"64g",
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::TaggedSymbol
                  )

                  sig {
                    override.returns(
                      T::Array[
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit::TaggedSymbol
                      ]
                    )
                  }
                  def self.values
                  end
                end

                # Network access policy for the container.
                module NetworkPolicy
                  extend OpenAI::Internal::Type::Union

                  Variants = T.type_alias {
                    T.any(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled,
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist
                    )
                  }

                  class Disabled < OpenAI::Internal::Type::BaseModel
                    OrHash = T.type_alias do
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled,
                        OpenAI::Internal::AnyHash
                      )
                    end

                    # Disable outbound network access. Always `disabled`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    sig do
                      params(

                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(

                      # Disable outbound network access. Always `disabled`.

                      type: :disabled
                    )
                    end

                    sig do
                      override.returns(
                        {type: Symbol}
                      )
                    end
                    def to_hash
                    end

                  end

                  class Allowlist < OpenAI::Internal::Type::BaseModel
                    OrHash = T.type_alias do
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist,
                        OpenAI::Internal::AnyHash
                      )
                    end

                    # A list of allowed domains when type is `allowlist`.
                    sig { returns(T::Array[String]) }
                    attr_accessor :allowed_domains

                    # Allow outbound network access only to specified domains. Always `allowlist`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    sig do
                      params(

                        allowed_domains: T::Array[String],

                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(

                      # A list of allowed domains when type is `allowlist`.
                      allowed_domains:,

                      # Allow outbound network access only to specified domains. Always `allowlist`.

                      type: :allowlist
                    )
                    end

                    sig do
                      override.returns(
                        {allowed_domains: T::Array[String], type: Symbol}
                      )
                    end
                    def to_hash
                    end

                  end

                  sig {
                    override.returns(
                      T::Array[
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Variants
                      ]
                    )
                  }
                  def self.variants
                  end

                end

                module Skill
                  extend OpenAI::Internal::Type::Union

                  Variants = T.type_alias {
                    T.any(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference,
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline
                    )
                  }

                  class SkillReference < OpenAI::Internal::Type::BaseModel
                    OrHash = T.type_alias do
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference,
                        OpenAI::Internal::AnyHash
                      )
                    end

                    # The ID of the referenced skill.
                    sig { returns(String) }
                    attr_accessor :skill_id

                    # References a skill created with the /v1/skills endpoint.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    # Optional skill version. Use a positive integer or 'latest'. Omit for default.
                    sig { returns(T.nilable(String)) }
                    attr_accessor :version

                    sig do
                      params(

                        skill_id: String,

                        version: T.nilable(String),

                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(

                      # The ID of the referenced skill.
                      skill_id:,

                      # Optional skill version. Use a positive integer or 'latest'. Omit for default.
                      version: nil,

                      # References a skill created with the /v1/skills endpoint.

                      type: :skill_reference
                    )
                    end

                    sig do
                      override.returns(
                        {skill_id: String, type: Symbol, version: T.nilable(String)}
                      )
                    end
                    def to_hash
                    end

                  end

                  class Inline < OpenAI::Internal::Type::BaseModel
                    OrHash = T.type_alias do
                      T.any(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline,
                        OpenAI::Internal::AnyHash
                      )
                    end

                    # The description of the skill.
                    sig { returns(String) }
                    attr_accessor :description

                    # The name of the skill.
                    sig { returns(String) }
                    attr_accessor :name

                    # Inline skill payload
                    sig {
                      returns(
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source
                      )
                    }
                    attr_reader :source

                    sig {
                      params(
                        source: OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::OrHash
                      )
                        .void
                    }
                    attr_writer :source

                    # Defines an inline skill for this request.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    sig do
                      params(

                        description: String,

                        name: String,

                        source: OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::OrHash,

                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(

                      # The description of the skill.
                      description:,

                      # The name of the skill.
                      name:,

                      # Inline skill payload
                      source:,

                      # Defines an inline skill for this request.

                      type: :inline
                    )
                    end

                    sig do
                      override.returns(
                        {
                          description: String,
                          name: String,
                          source: OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source,
                          type: Symbol
                        }
                      )
                    end
                    def to_hash
                    end

                    class Source < OpenAI::Internal::Type::BaseModel
                      OrHash = T.type_alias do
                        T.any(
                          OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source,
                          OpenAI::Internal::AnyHash
                        )
                      end

                      # Base64-encoded skill zip bundle.
                      sig { returns(String) }
                      attr_accessor :data

                      # The media type of the inline skill payload. Must be `application/zip`.
                      sig { returns(Symbol) }
                      attr_accessor :media_type

                      # The type of the inline skill source. Must be `base64`.
                      sig { returns(Symbol) }
                      attr_accessor :type

                      # Inline skill payload
                      sig do
                        params(

                          data: String,

                          media_type: Symbol,

                          type: Symbol
                        )
                          .returns(T.attached_class)
                      end
                      def self.new(

                        # Base64-encoded skill zip bundle.
                        data:,

                        # The media type of the inline skill payload. Must be `application/zip`.
                        media_type: :"application/zip",

                        # The type of the inline skill source. Must be `base64`.

                        type: :base64
                      )
                      end

                      sig do
                        override.returns(
                          {data: String, media_type: Symbol, type: Symbol}
                        )
                      end
                      def to_hash
                      end

                    end
                  end

                  sig {
                    override.returns(
                      T::Array[
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Variants
                      ]
                    )
                  }
                  def self.variants
                  end

                end
              end

              class ContainerReference < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The ID of the referenced container.
                sig { returns(String) }
                attr_accessor :container_id

                # References a container created with the /v1/containers endpoint
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    container_id: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The ID of the referenced container.
                  container_id:,

                  # References a container created with the /v1/containers endpoint

                  type: :container_reference
                )
                end

                sig do
                  override.returns(
                    {container_id: String, type: Symbol}
                  )
                end
                def to_hash
                end

              end

              class Local < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Use a local computer environment.
                sig { returns(Symbol) }
                attr_accessor :type

                # An optional list of skills.
                sig {
                  returns(
                    T.nilable(T::Array[OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill])
                  )
                }
                attr_accessor :skills

                sig do
                  params(

                    skills: T.nilable(
                      T::Array[OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill::OrHash]
                    ),

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # An optional list of skills.
                  skills: nil,

                  # Use a local computer environment.

                  type: :local
                )
                end

                sig do
                  override.returns(
                    {
                      type: Symbol,
                      skills: T.nilable(
                        T::Array[OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill]
                      )
                    }
                  )
                end
                def to_hash
                end

                class Skill < OpenAI::Internal::Type::BaseModel
                  OrHash = T.type_alias do
                    T.any(
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill,
                      OpenAI::Internal::AnyHash
                    )
                  end

                  # The description of the skill.
                  sig { returns(String) }
                  attr_accessor :description

                  # The name of the skill.
                  sig { returns(String) }
                  attr_accessor :name

                  # The path to the directory containing the skill.
                  sig { returns(String) }
                  attr_accessor :path

                  sig do
                    params(

                      description: String,

                      name: String,

                      path: String
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(

                    # The description of the skill.
                    description:,

                    # The name of the skill.
                    name:,

                    # The path to the directory containing the skill.

                    path:
                  )
                  end

                  sig do
                    override.returns(
                      {description: String, name: String, path: String}
                    )
                  end
                  def to_hash
                  end

                end
              end

              sig {
                override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Variants])
              }
              def self.variants
              end

            end
          end

          class ImageGeneration < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :image_generation
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Mcp < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :mcp
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Custom < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::Custom,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :custom
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Namespace < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :namespace
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class ToolSearch < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :tool_search
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :programmatic_tool_calling
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class Computer < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::Computer,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :computer
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          class ApplyPatch < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type: :apply_patch
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationConfig::Tool::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
