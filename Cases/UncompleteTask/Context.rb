# encoding: utf-8
require 'Tinto/Context'

module Tintodo
  module UncompleteTask
    class Context
      include Tinto::Context

      def initialize(arguments)
        @task             = arguments.fetch(:task)
        @pending_tasks    = arguments.fetch(:pending_tasks)
        @completed_tasks  = arguments.fetch(:completed_tasks)
      end #initialize

      def call
        task            .uncomplete
        pending_tasks   .add task
        completed_tasks .delete task

        will_sync task, pending_tasks, completed_tasks
      end #call

      private

      attr_reader :task, :pending_tasks, :completed_tasks
    end # Context
  end # UncompleteTask
end # Tintodo

