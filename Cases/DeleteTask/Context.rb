# encoding: utf-8
require 'Tinto/Context'

module Tintodo
  module DeleteTask
    class Context
      include Tinto::Context

      def initialize(arguments)
        @task             = arguments.fetch(:task)
        @tasks            = arguments.fetch(:tasks)
        @pending_tasks    = arguments.fetch(:pending_tasks)
        @completed_tasks  = arguments.fetch(:completed_tasks)
      end #initialize

      def call
        task            .delete
        tasks           .delete task
        pending_tasks   .delete task
        completed_tasks .delete task

        will_sync task, tasks, pending_tasks, completed_tasks
      end #call

      private

      attr_reader :task, :tasks, :pending_tasks, :completed_tasks
    end # Context
  end # DeleteTask
end # Tintodo

