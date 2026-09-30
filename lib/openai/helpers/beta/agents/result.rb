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
          MessageState = Struct.new(:index, :phase, :done, :complete, :message, keyword_init: true)
          private_constant :MessageState

          def initialize(session_id: nil, handler_names: [])
            @session_id = session_id
            @handler_names = handler_names
            @messages = {}
            @unfinished = {}
            @required_actions = []
          end

          def observe(event)
            return if @finished

            case event.type
            when :"agent.session.created"
              @session_id ||= event.session.id.dup
            when :"agent.session.turn.created"
              if @turn.nil? && event.turn.subagent_id.nil? && (@session_id.nil? || event.session_id == @session_id)
                @turn = copy(event.turn)
                @session_id = @turn.session_id
              end

            when :"agent.session.turn.completed", :"agent.session.turn.failed", :"agent.session.turn.cancelled"
              if @turn && event.turn_id == @turn.id
                @turn = copy(event.turn)
                @terminal = true
                @required_actions = []
              end

            when :"agent.session.turn.item.added", :"agent.session.turn.item.done"
              if @turn && event.item.type == :message && event.item.turn_id == @turn.id && event.item.role == :assistant
                item = event.item
                done = event.type == :"agent.session.turn.item.done"
                # A replayed added snapshot must not replace a completed item.
                return if !done && @messages[item.id]&.done

                phase = item.phase if [:final_answer, :commentary].include?(item.phase)
                complete = done && item.status == :completed
                @messages[item.id] = MessageState.new(
                  index: event.output_index,
                  phase: phase,
                  done: done,
                  complete: complete,
                  message: (copy(item) if complete && phase == :final_answer)
                )
                @unfinished.delete(item.id) if done
              end

            when :"agent.session.turn.output_text.delta", :"agent.session.turn.output_text.done"
              if @turn &&
                  (event.turn_id == @turn.id || @messages.key?(event.item_id)) &&
                  !@messages[event.item_id]&.done
                @unfinished[event.item_id] = true
              end

            when :"agent.session.requires_action"
              @required_actions = event.session.required_actions.filter_map do |action|
                next if action.type == :function_call && @handler_names.include?(action.name)
                copy(action)
              end

            when :"agent.session.idle"
              @finished = true if @terminal && event.session.id == @session_id
            when :"agent.session.failed"
              @session_id ||= event.session.id.dup
              @failure = :failed
              @finished = true
            end
          end

          def stopped?
            @finished || !@required_actions.empty? || (@terminal && @turn.status != :completed)
          end

          def observe_error(error)
            @cause ||= error unless @finished
          end

          def result
            return @result if @result
            raise error(:observation_error), cause: @cause if @cause
            raise error(@failure) if @failure
            raise error(@turn.status) if @terminal && @turn.status != :completed
            raise error(:requires_action) unless @required_actions.empty?
            raise error(:incomplete) unless @finished && @turn&.status == :completed

            raise error(:incomplete) unless @unfinished.empty?

            entries = @messages.values
            raise error(:output_selection) if entries.any? { |state| state.phase.nil? }
            if entries.any? { |state|
                state.phase == :final_answer && (!state.complete || !state.index.is_a?(Integer))
              }
              raise error(:incomplete)
            end

            @result = TurnResult.new(turn: @turn, messages: final_messages)
            @messages.clear
            @unfinished.clear
            @result
          end

          private

          def final_messages
            @messages
              .values
              .select { |state| state.message && state.index.is_a?(Integer) }
              .sort_by(&:index)
              .map do |state|
                OpenAI::Internal::Type::Converter.coerce(
                  OpenAI::Models::Beta::AgentSessionMessage,
                  state.message.deep_to_h
                )
              end
          end

          def error(reason)
            ResultError.new(
              reason: reason,
              session_id: @session_id,
              turn: @turn,
              messages: final_messages,
              required_actions: @required_actions
            )
          end

          def copy(value)
            raw = JSON.parse(JSON.generate(value), symbolize_names: true)
            OpenAI::Internal::Type::Converter.coerce(value.class, raw)
          end
        end
      end
    end
  end
end
