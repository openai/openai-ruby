# frozen_string_literal: true

module OpenAI
  module Helpers
    module Beta
      module Agents
        # The final output of one completed root turn (beta).
        # Messages contain final assistant answers, not the session transcript.
        class TurnResult
          attr_reader :turn, :messages

          # @api private
          def initialize(turn:, messages:)
            @turn = turn
            @messages = messages.freeze
          end

          def session_id = turn.session_id
          def turn_id = turn.id

          # Joins text without adding separators or making requests.
          def output_text = messages.map(&:output_text).join

          # A raw result has no parser attached.
          def output_parsed = nil

          # Parse this completed answer without changing the hosted session.
          def parse(output_type:)
            OutputParser.new(output_type).parse(self)
          end
        end

        # Collection failed, or the observed turn did not complete successfully.
        # A transport failure describes observation, not failure of hosted work.
        class ResultError < OpenAI::Errors::Error
          attr_reader :reason, :session_id, :turn, :messages, :required_actions

          # @api private
          def initialize(reason:, session_id:, turn:, messages:, required_actions: [])
            @reason = reason
            @session_id = session_id
            @turn = turn
            @messages = messages.freeze
            @required_actions = required_actions.freeze
            super("Unable to collect the agent turn result: #{reason}")
          end

          def turn_id = turn&.id
        end

        # @api private
        class ResultCollector
          def initialize(session_id: nil, handler_names: [])
            @session_id = session_id
            @handler_names = handler_names
            @messages = {}
            @required_actions = []
          end

          def enable
            return if @enabled
            if @started
              raise ArgumentError, "Call with_result_collection before consuming events to collect a final result"
            end

            @enabled = true
          end

          def observe(event, current_root: true)
            @started = true
            return unless @enabled
            return if @finished || !event.is_a?(OpenAI::Internal::Type::BaseModel)

            case event.type
            when :"agent.session.created"
              @session_id ||= event.session.id.dup
            when :"agent.session.turn.created"
              if !@scope_actions &&
                  @turn.nil? &&
                  event.turn.subagent_id.nil? &&
                  (@session_id.nil? || event.session_id == @session_id)
                @turn = copy(event.turn)
                @session_id = @turn.session_id
              end

            when :"agent.session.turn.completed", :"agent.session.turn.failed", :"agent.session.turn.cancelled"
              if @turn && event.turn_id == @turn.id
                @turn = copy(event.turn)
                @terminal = true
                @required_actions = []
              end

            when :"agent.session.turn.item.done"
              item = event.item
              if @turn &&
                  item.is_a?(OpenAI::Models::Beta::AgentSessionAssistantMessage) &&
                  item.turn_id == @turn.id &&
                  item.role == :assistant &&
                  item.status == :completed &&
                  item.phase != :commentary
                @messages[item.id] = [event.output_index, copy(item, OpenAI::Models::Beta::AgentSessionMessage)]
              end

            when :"agent.session.requires_action"
              @required_actions = event.session.required_actions.filter_map do |action|
                if @scope_actions

                  action_turn = action[:turn_id]
                  action_turn ||= action["turn_id"] if action.is_a?(Hash)
                  next if action_turn ? action_turn != @turn&.id : !current_root
                end

                if action.is_a?(OpenAI::Models::Beta::AgentSession::RequiredAction::FunctionCall) &&
                    @handler_names.include?(action.name)
                  next
                end

                copy(action)
              end

            when :"agent.session.in_progress"
              @required_actions = [] if event.session.id == @session_id
            when :"agent.session.idle"
              @finished = true if @terminal && event.session.id == @session_id
            when :"agent.session.failed"
              @session_id ||= event.session.id.dup
              @failure = :failed
              @finished = true
            end
          end

          def select_turn(turn)
            return unless @enabled
            @scope_actions = true
            return if turn.nil? || @turn || @finished
            @turn = copy(turn)
            @terminal = [:completed, :failed, :cancelled].include?(@turn.status)
          end

          def observe_pending_action(action)
            return unless @enabled && !@finished
            @required_actions << copy(action, OpenAI::Models::Beta::AgentSession::RequiredAction)
          end

          def recover(turn:, items:, failed:)
            return unless @enabled
            return if @result || @result_error
            if turn
              @turn = turn
              @terminal = [:completed, :failed, :cancelled].include?(@turn.status)
              messages = {}
              items.each_with_index do |item, index|
                unless item.is_a?(OpenAI::Models::Beta::AgentSessionMessage) &&
                    item.turn_id == turn.id &&
                    item.role == :assistant &&
                    item.status == :completed &&
                    item.phase != :commentary
                  next
                end

                messages[item.id] = [index, item]
              end

              @messages = messages
            end

            @required_actions = [] if @terminal
            @failure = nil if @terminal
            @failure = :failed if failed
            @failure = :no_turn if turn.nil? && @required_actions.empty? && !failed
            @finished = @terminal || failed || turn.nil?
          rescue StandardError => error
            observe_recovery_error(error)
          end

          def observe_recovery_error(error)
            return if @failure || !@required_actions.empty? || (@terminal && @turn.status != :completed)
            @cause ||= error
          end

          def stopped?
            @finished || !@required_actions.empty? || (@terminal && @turn.status != :completed)
          end

          def observe_error(error)
            @cause ||= error if @enabled && !@finished
          end

          def result
            return @result if @result
            raise @result_error if @result_error
            raise error(:observation_error), cause: @cause if @cause
            raise error(@failure) if @failure
            raise error(@turn.status) if @terminal && @turn.status != :completed
            raise error(:requires_action) unless @required_actions.empty?
            raise error(:incomplete) unless @finished && @turn&.status == :completed

            @result = TurnResult.new(turn: @turn, messages: take_messages)
          end

          private

          def take_messages
            messages = @messages.values.sort_by(&:first).map(&:last)
            @messages.clear
            messages
          end

          def error(reason)
            @result_error = ResultError.new(
              reason: reason,
              session_id: @session_id,
              turn: @turn,
              messages: take_messages,
              required_actions: @required_actions
            )
          end

          def copy(value, model = value.class)
            raw = JSON.parse(JSON.generate(value), symbolize_names: true)
            OpenAI::Internal::Type::Converter.coerce(model, raw)
          end
        end
      end
    end
  end
end

require_relative "typed_output"
