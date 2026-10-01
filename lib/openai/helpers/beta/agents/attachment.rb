# frozen_string_literal: true

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Tracks a saved session's selected root turn without replaying tool actions.
        # @api private
        class Attachment
          attr_reader :turn

          def initialize(sessions:, session_id:, request_options:)
            @sessions = sessions
            @session_id = session_id
            @options = request_options
            baseline = latest_root
            @baseline_id = baseline&.id
            @turn = baseline unless baseline.nil? || terminal?(baseline)
          end

          def opened
            if @turn.nil?
              candidate = latest_root
              @turn = candidate if candidate && candidate.id != @baseline_id
            end

            refresh
          end

          def observe(event)
            case event.type
            when
                :"agent.session.turn.created",
                :"agent.session.turn.in_progress",
                :"agent.session.turn.completed",
                :"agent.session.turn.failed",
                :"agent.session.turn.cancelled"
              candidate = event.turn
              if root?(candidate) && (@turn ? @turn.id == candidate.id : new_root?(candidate))
                @turn = OpenAI::Internal::Type::Converter.coerce(
                  OpenAI::Models::Beta::Agents::Sessions::Turn,
                  JSON.parse(JSON.generate(candidate), symbolize_names: true)
                )
              end

            when :"agent.session.turn.item.added", :"agent.session.turn.item.done"
              if @turn.nil? && event.session_id == @session_id
                item = event.item
                id = case item
                when
                    OpenAI::Models::Beta::AgentFunctionCallItem,
                    OpenAI::Models::Beta::AgentSessionItem::ComputerUseApprovalRequest,
                    OpenAI::Models::Beta::AgentSessionItem::ComputerUseApprovalRequestResult,
                    OpenAI::Models::Beta::AgentSessionAssistantMessage,
                    OpenAI::Models::Beta::AgentSessionMessage
                  item.turn_id
                else
                  event.turn_id
                end

                if id
                  candidate = @sessions.turns.retrieve(id, session_id: @session_id, request_options: @options)
                  @turn = candidate if new_root?(candidate)
                end
              end

            when :"agent.session.idle"
              if event.session.id == @session_id
                if @turn.nil?
                  candidate = latest_root
                  @turn = candidate if candidate && candidate.id != @baseline_id
                  @status = @sessions.retrieve(@session_id, request_options: @options).status
                else
                  unless terminal?(@turn)
                    @turn = @sessions.turns.retrieve(@turn.id, session_id: @session_id, request_options: @options)
                  end

                  @status = :idle
                end
              end

            when :"agent.session.failed"
              @status = :failed if event.session.id == @session_id
            when :"agent.session.in_progress"
              @status = :in_progress if event.session.id == @session_id
            when :"agent.session.requires_action"
              @status = :requires_action if event.session.id == @session_id
            end
          end

          def settled?
            @status == :failed || (@turn && terminal?(@turn)) || (@status == :idle && @turn.nil?)
          end

          def manual_actions
            return [] unless @turn&.status == :waiting || (@turn.nil? && @status == :requires_action)
            if @turn
              @turn = @sessions.turns.retrieve(@turn.id, session_id: @session_id, request_options: @options)
            end

            session = @sessions.retrieve(@session_id, request_options: @options)
            @status = session.status
            return [] unless @status == :requires_action
            session.required_actions.select do |action|
              case action
              when OpenAI::Models::Beta::AgentSession::RequiredAction::ComputerUseApprovalRequest
                @turn&.status == :waiting && action.turn_id == @turn.id
              when OpenAI::Models::Beta::AgentSession::RequiredAction::EnvironmentConnection
                candidate = latest_root
                @turn ? @turn.status == :waiting && candidate&.id == @turn.id : candidate.nil? || terminal?(candidate)
              when Hash
                next false if (action[:type] || action["type"]).to_s == "function_call"
                id = action[:turn_id] || action["turn_id"]
                if @turn
                  @turn.status == :waiting && (id ? id == @turn.id : current_root?)
                else
                  id.nil? && current_root?
                end
              else
                false
              end
            end
          end

          def current_root?
            candidate = latest_root
            @turn ? candidate&.id == @turn.id : candidate.nil? || terminal?(candidate)
          end

          def recover_observation
            if @turn.nil?
              candidate = latest_root
              @turn = candidate if candidate && candidate.id != @baseline_id
            end

            return false unless @turn
            @read_reconciled = true
            @turn = @sessions.turns.retrieve(@turn.id, session_id: @session_id, request_options: @options)
            terminal?(@turn)
          rescue StandardError
            false
          end

          def reconcile(collector)
            if @turn && !@read_reconciled
              @turn = @sessions.turns.retrieve(@turn.id, session_id: @session_id, request_options: @options)
            end

            items = Enumerator.new do |yielder|
              if @turn
                @sessions
                  .items
                  .list(@session_id, order: :asc, limit: 100, request_options: @options)
                  .auto_paging_each do |item|
                    yielder << item
                  end
              end
            end

            collector.recover(turn: @turn, items: items, failed: @status == :failed && !(@turn && terminal?(@turn)))
          end

          private

          def new_root?(candidate)
            root?(candidate) && candidate.id != @baseline_id && latest_root&.id == candidate.id
          end

          def root?(turn) = turn.session_id == @session_id && turn.subagent_id.nil?

          def terminal?(turn) = [:completed, :failed, :cancelled].include?(turn.status)

          def latest_root
            @sessions
              .turns
              .list(@session_id, order: :desc, limit: 100, request_options: @options)
              .auto_paging_each do |turn|
                next unless root?(turn)
                return turn
              end

            nil
          end

          def refresh
            if @turn
              @turn = @sessions.turns.retrieve(@turn.id, session_id: @session_id, request_options: @options)
            end

            session = @sessions.retrieve(@session_id, request_options: @options)
            @status = session.status
          end
        end
      end
    end
  end
end
