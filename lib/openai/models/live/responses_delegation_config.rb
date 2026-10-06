# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ResponsesDelegationConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute model
        #   The model used for server-owned Responses delegations.
        #
        #   @return [String]
        required :model, String

        # @!attribute instructions
        #   Instructions for the delegated Responses model, separate from Live instructions.
        #   See
        #   [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute max_output_tokens
        #   Maximum number of output tokens for each delegated response.
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

        # @!attribute parallel_tool_calls
        #   Whether the delegated Responses model may request multiple tool calls in a
        #   single response.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute reasoning
        #   Reasoning settings passed to each delegated Responses request.
        #
        #   @return [OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Live::ResponsesDelegationConfig::Reasoning }, nil?: true

        # @!attribute service_tier
        #   Service tier for delegated Responses requests.
        #
        #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Live::ResponsesDelegationConfig::ServiceTier }, nil?: true

        # @!attribute text
        #   Text generation settings passed to each delegated Responses request.
        #
        #   @return [OpenAI::Models::Live::ResponsesDelegationConfig::Text, nil]
        optional :text, -> { OpenAI::Live::ResponsesDelegationConfig::Text }, nil?: true

        # @!attribute tool_choice
        #   Controls which tool the Responses backend uses when handling a task delegated by
        #   the Live model.
        #
        #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum, Hash{Symbol=>Object}, nil]
        optional :tool_choice, union: -> { OpenAI::Live::ResponsesDelegationConfig::ToolChoice }

        # @!attribute tools
        #   Tools available to the Responses backend while it handles tasks delegated by the
        #   Live model.
        #
        #   @return [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ApplyPatch>, nil]
        optional(
          :tools,
          -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::ResponsesDelegationConfig::Tool] }
        )

        # @!method initialize(model:, instructions: nil, max_output_tokens: nil, parallel_tool_calls: nil, reasoning: nil, service_tier: nil, text: nil, tool_choice: nil, tools: nil)
        #   Model, prompt, and tool settings for tasks delegated by the Live session to a
        #   Responses backend.
        #
        #   @param model [String]
        #     The model used for server-owned Responses delegations.
        #
        #   @param instructions [String, nil]
        #     Instructions for the delegated Responses model, separate from Live instructions.
        #     See
        #     [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #
        #   @param max_output_tokens [Integer, nil]
        #     Maximum number of output tokens for each delegated response.
        #
        #   @param parallel_tool_calls [Boolean, nil]
        #     Whether the delegated Responses model may request multiple tool calls in a
        #     single response.
        #
        #   @param reasoning [OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning, nil]
        #     Reasoning settings passed to each delegated Responses request.
        #
        #   @param service_tier [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::ServiceTier, nil]
        #     Service tier for delegated Responses requests.
        #
        #   @param text [OpenAI::Models::Live::ResponsesDelegationConfig::Text, nil]
        #     Text generation settings passed to each delegated Responses request.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum, Hash{Symbol=>Object}]
        #     Controls which tool the Responses backend uses when handling a task delegated by
        #     the Live model.
        #
        #   @param tools [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ApplyPatch>]
        #     Tools available to the Responses backend while it handles tasks delegated by the
        #     Live model.

        # @see OpenAI::Models::Live::ResponsesDelegationConfig#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   How much reasoning effort the delegated Responses model should use. Supported
          #   values depend on the backend model.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning::Effort, nil]
          optional(
            :effort,
            enum: -> {
              OpenAI::Live::ResponsesDelegationConfig::Reasoning::Effort
            },
            nil?: true
          )

          # @!attribute summary
          #   The reasoning summary to request from the delegated Responses model, when
          #   supported.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning::Summary, nil]
          optional(
            :summary,
            enum: -> {
              OpenAI::Live::ResponsesDelegationConfig::Reasoning::Summary
            },
            nil?: true
          )

          # @!method initialize(effort: nil, summary: nil)
          #   Reasoning settings passed to each delegated Responses request.
          #
          #   @param effort [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning::Effort, nil]
          #     How much reasoning effort the delegated Responses model should use. Supported
          #     values depend on the backend model.
          #
          #   @param summary [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning::Summary, nil]
          #     The reasoning summary to request from the delegated Responses model, when
          #     supported.

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning#effort
          module Effort
            extend OpenAI::Internal::Type::Enum

            NONE = :none
            MINIMAL = :minimal
            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            XHIGH = :xhigh

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationConfig::Reasoning#summary
          module Summary
            extend OpenAI::Internal::Type::Enum

            CONCISE = :concise
            DETAILED = :detailed
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Service tier for delegated Responses requests.
        #
        # @see OpenAI::Models::Live::ResponsesDelegationConfig#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FAST_TIER_TEMP_PILOT = :fast_tier_temp_pilot
          FLEX = :flex
          PRIORITY = :priority
          ULTRAFAST = :ultrafast

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Live::ResponsesDelegationConfig#text
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute verbosity
          #   The amount of detail in text generated by the Responses backend. This does not
          #   configure the Live model’s spoken delivery.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Text::Verbosity, nil]
          optional(
            :verbosity,
            enum: -> {
              OpenAI::Live::ResponsesDelegationConfig::Text::Verbosity
            },
            nil?: true
          )

          # @!method initialize(verbosity: nil)
          #   Text generation settings passed to each delegated Responses request.
          #
          #   @param verbosity [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Text::Verbosity, nil]
          #     The amount of detail in text generated by the Responses backend. This does not
          #     configure the Live model’s spoken delivery.

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationConfig::Text#verbosity
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        #
        # @see OpenAI::Models::Live::ResponsesDelegationConfig#tool_choice
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          # Controls which tool the Responses backend uses when handling a task delegated by the Live model.
          variant enum: -> { OpenAI::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum }

          variant -> { OpenAI::Models::Live::ResponsesDelegationConfig::ToolChoice::UnionMember1Map }

          # Controls which tool the Responses backend uses when handling a task delegated by
          # the Live model.
          module LiveToolChoiceEnum
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            NONE = :none
            REQUIRED = :required

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::ToolChoice::LiveToolChoiceEnum, Hash{Symbol=>Object})]

          # @type [OpenAI::Internal::Type::Converter]
          UnionMember1Map = OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]
        end

        # A function tool available to the Responses backend when the Live model delegates
        # a task.
        module Tool
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A function tool available to the Responses backend when the Live model delegates a task.
          variant :function, -> { OpenAI::Live::FunctionTool }

          # A web search tool available to the Live session’s Responses backend.
          variant :web_search, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::WebSearch }

          variant :file_search, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::FileSearch }

          variant :code_interpreter, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::CodeInterpreter }

          # A Responses shell tool. Use a hosted container or return local shell results with response.item.create. Domain secrets are not supported.
          variant :shell, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Shell }

          variant :image_generation, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::ImageGeneration }

          variant :mcp, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Mcp }

          variant :custom, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Custom }

          variant :namespace, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Namespace }

          variant :tool_search, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::ToolSearch }

          variant(
            :programmatic_tool_calling,
            -> { OpenAI::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling }
          )

          variant :computer, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Computer }

          variant :apply_patch, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::ApplyPatch }

          class WebSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool type. Always `web_search`.
            #
            #   @return [Symbol, :web_search]
            required :type, const: :web_search

            # @!method initialize(type: :web_search)
            #   A web search tool available to the Live session’s Responses backend.
            #
            #   @param type [Symbol, :web_search]
            #     The tool type. Always `web_search`.
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!method initialize(type: :file_search)
            #   @param type [Symbol, :file_search]
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!method initialize(type: :code_interpreter)
            #   @param type [Symbol, :code_interpreter]
          end

          class Shell < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :shell]
            required :type, const: :shell

            # @!attribute environment
            #
            #   @return [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local, nil]
            optional(
              :environment,
              union: -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment },
              nil?: true
            )

            # @!method initialize(environment: nil, type: :shell)
            #   A Responses shell tool. Use a hosted container or return local shell results
            #   with response.item.create. Domain secrets are not supported.
            #
            #   @param environment [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local, nil]
            #   @param type [Symbol, :shell]

            # @see OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell#environment
            module Environment
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant(
                :container_auto,
                -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto }
              )

              variant(
                :container_reference,
                -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference }
              )

              variant :local, -> { OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local }

              class ContainerAuto < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Automatically creates a container for this request
                #
                #   @return [Symbol, :container_auto]
                required :type, const: :container_auto

                # @!attribute file_ids
                #   An optional list of uploaded files to make available to your code.
                #
                #   @return [Array<String>, nil]
                optional :file_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

                # @!attribute memory_limit
                #   The memory limit for the container.
                #
                #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit, nil]
                optional(
                  :memory_limit,
                  enum: -> {
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit
                  },
                  nil?: true
                )

                # @!attribute network_policy
                #   Network access policy for the container.
                #
                #   @return [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist, nil]
                optional(
                  :network_policy,
                  union: -> {
                    OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy
                  },
                  nil?: true
                )

                # @!attribute skills
                #   An optional list of skills referenced by id or inline data.
                #
                #   @return [Array<OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline>, nil]
                optional(
                  :skills,
                  -> {
                    OpenAI::Internal::Type::ArrayOf[
                      union: OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill
                    ]
                  },
                  nil?: true
                )

                # @!method initialize(file_ids: nil, memory_limit: nil, network_policy: nil, skills: nil, type: :container_auto)
                #   @param file_ids [Array<String>, nil]
                #     An optional list of uploaded files to make available to your code.
                #
                #   @param memory_limit [Symbol, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit, nil]
                #     The memory limit for the container.
                #
                #   @param network_policy [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist, nil]
                #     Network access policy for the container.
                #
                #   @param skills [Array<OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline>, nil]
                #     An optional list of skills referenced by id or inline data.
                #
                #   @param type [Symbol, :container_auto]
                #     Automatically creates a container for this request

                # The memory limit for the container.
                #
                # @see OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto#memory_limit
                module MemoryLimit
                  extend OpenAI::Internal::Type::Enum

                  MEMORY_LIMIT_1G = :"1g"
                  MEMORY_LIMIT_4G = :"4g"
                  MEMORY_LIMIT_16G = :"16g"
                  MEMORY_LIMIT_64G = :"64g"

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # Network access policy for the container.
                #
                # @see OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto#network_policy
                module NetworkPolicy
                  extend OpenAI::Internal::Type::Union

                  discriminator :type

                  variant(
                    :disabled,
                    -> {
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled
                    }
                  )

                  variant(
                    :allowlist,
                    -> {
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist
                    }
                  )

                  class Disabled < OpenAI::Internal::Type::BaseModel
                    # @!attribute type
                    #   Disable outbound network access. Always `disabled`.
                    #
                    #   @return [Symbol, :disabled]
                    required :type, const: :disabled

                    # @!method initialize(type: :disabled)
                    #   @param type [Symbol, :disabled]
                    #     Disable outbound network access. Always `disabled`.
                  end

                  class Allowlist < OpenAI::Internal::Type::BaseModel
                    # @!attribute allowed_domains
                    #   A list of allowed domains when type is `allowlist`.
                    #
                    #   @return [Array<String>]
                    required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

                    # @!attribute type
                    #   Allow outbound network access only to specified domains. Always `allowlist`.
                    #
                    #   @return [Symbol, :allowlist]
                    required :type, const: :allowlist

                    # @!method initialize(allowed_domains:, type: :allowlist)
                    #   @param allowed_domains [Array<String>]
                    #     A list of allowed domains when type is `allowlist`.
                    #
                    #   @param type [Symbol, :allowlist]
                    #     Allow outbound network access only to specified domains. Always `allowlist`.
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist)]
                end

                module Skill
                  extend OpenAI::Internal::Type::Union

                  discriminator :type

                  variant(
                    :skill_reference,
                    -> {
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference
                    }
                  )

                  variant(
                    :inline,
                    -> {
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline
                    }
                  )

                  class SkillReference < OpenAI::Internal::Type::BaseModel
                    # @!attribute skill_id
                    #   The ID of the referenced skill.
                    #
                    #   @return [String]
                    required :skill_id, String

                    # @!attribute type
                    #   References a skill created with the /v1/skills endpoint.
                    #
                    #   @return [Symbol, :skill_reference]
                    required :type, const: :skill_reference

                    # @!attribute version
                    #   Optional skill version. Use a positive integer or 'latest'. Omit for default.
                    #
                    #   @return [String, nil]
                    optional :version, String, nil?: true

                    # @!method initialize(skill_id:, version: nil, type: :skill_reference)
                    #   @param skill_id [String]
                    #     The ID of the referenced skill.
                    #
                    #   @param version [String, nil]
                    #     Optional skill version. Use a positive integer or 'latest'. Omit for default.
                    #
                    #   @param type [Symbol, :skill_reference]
                    #     References a skill created with the /v1/skills endpoint.
                  end

                  class Inline < OpenAI::Internal::Type::BaseModel
                    # @!attribute description
                    #   The description of the skill.
                    #
                    #   @return [String]
                    required :description, String

                    # @!attribute name
                    #   The name of the skill.
                    #
                    #   @return [String]
                    required :name, String

                    # @!attribute source
                    #   Inline skill payload
                    #
                    #   @return [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source]
                    required(
                      :source,
                      -> {
                        OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source
                      }
                    )

                    # @!attribute type
                    #   Defines an inline skill for this request.
                    #
                    #   @return [Symbol, :inline]
                    required :type, const: :inline

                    # @!method initialize(description:, name:, source:, type: :inline)
                    #   @param description [String]
                    #     The description of the skill.
                    #
                    #   @param name [String]
                    #     The name of the skill.
                    #
                    #   @param source [OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source]
                    #     Inline skill payload
                    #
                    #   @param type [Symbol, :inline]
                    #     Defines an inline skill for this request.

                    # @see OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline#source
                    class Source < OpenAI::Internal::Type::BaseModel
                      # @!attribute data
                      #   Base64-encoded skill zip bundle.
                      #
                      #   @return [String]
                      required :data, String

                      # @!attribute media_type
                      #   The media type of the inline skill payload. Must be `application/zip`.
                      #
                      #   @return [Symbol, :"application/zip"]
                      required :media_type, const: :"application/zip"

                      # @!attribute type
                      #   The type of the inline skill source. Must be `base64`.
                      #
                      #   @return [Symbol, :base64]
                      required :type, const: :base64

                      # @!method initialize(data:, media_type: :"application/zip", type: :base64)
                      #   Inline skill payload
                      #
                      #   @param data [String]
                      #     Base64-encoded skill zip bundle.
                      #
                      #   @param media_type [Symbol, :"application/zip"]
                      #     The media type of the inline skill payload. Must be `application/zip`.
                      #
                      #   @param type [Symbol, :base64]
                      #     The type of the inline skill source. Must be `base64`.
                    end
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline)]
                end
              end

              class ContainerReference < OpenAI::Internal::Type::BaseModel
                # @!attribute container_id
                #   The ID of the referenced container.
                #
                #   @return [String]
                required :container_id, String

                # @!attribute type
                #   References a container created with the /v1/containers endpoint
                #
                #   @return [Symbol, :container_reference]
                required :type, const: :container_reference

                # @!method initialize(container_id:, type: :container_reference)
                #   @param container_id [String]
                #     The ID of the referenced container.
                #
                #   @param type [Symbol, :container_reference]
                #     References a container created with the /v1/containers endpoint
              end

              class Local < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Use a local computer environment.
                #
                #   @return [Symbol, :local]
                required :type, const: :local

                # @!attribute skills
                #   An optional list of skills.
                #
                #   @return [Array<OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill>, nil]
                optional(
                  :skills,
                  -> {
                    OpenAI::Internal::Type::ArrayOf[
                      OpenAI::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill
                    ]
                  },
                  nil?: true
                )

                # @!method initialize(skills: nil, type: :local)
                #   @param skills [Array<OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local::Skill>, nil]
                #     An optional list of skills.
                #
                #   @param type [Symbol, :local]
                #     Use a local computer environment.
                class Skill < OpenAI::Internal::Type::BaseModel
                  # @!attribute description
                  #   The description of the skill.
                  #
                  #   @return [String]
                  required :description, String

                  # @!attribute name
                  #   The name of the skill.
                  #
                  #   @return [String]
                  required :name, String

                  # @!attribute path
                  #   The path to the directory containing the skill.
                  #
                  #   @return [String]
                  required :path, String

                  # @!method initialize(description:, name:, path:)
                  #   @param description [String]
                  #     The description of the skill.
                  #
                  #   @param name [String]
                  #     The name of the skill.
                  #
                  #   @param path [String]
                  #     The path to the directory containing the skill.
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell::Environment::Local)]
            end
          end

          class ImageGeneration < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :image_generation]
            required :type, const: :image_generation

            # @!method initialize(type: :image_generation)
            #   @param type [Symbol, :image_generation]
          end

          class Mcp < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :mcp]
            required :type, const: :mcp

            # @!method initialize(type: :mcp)
            #   @param type [Symbol, :mcp]
          end

          class Custom < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :custom]
            required :type, const: :custom

            # @!method initialize(type: :custom)
            #   @param type [Symbol, :custom]
          end

          class Namespace < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :namespace]
            required :type, const: :namespace

            # @!method initialize(type: :namespace)
            #   @param type [Symbol, :namespace]
          end

          class ToolSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :tool_search]
            required :type, const: :tool_search

            # @!method initialize(type: :tool_search)
            #   @param type [Symbol, :tool_search]
          end

          class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :programmatic_tool_calling]
            required :type, const: :programmatic_tool_calling

            # @!method initialize(type: :programmatic_tool_calling)
            #   @param type [Symbol, :programmatic_tool_calling]
          end

          class Computer < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :computer]
            required :type, const: :computer

            # @!method initialize(type: :computer)
            #   @param type [Symbol, :computer]
          end

          class ApplyPatch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :apply_patch]
            required :type, const: :apply_patch

            # @!method initialize(type: :apply_patch)
            #   @param type [Symbol, :apply_patch]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationConfig::Tool::ApplyPatch)]
        end
      end
    end
  end
end
