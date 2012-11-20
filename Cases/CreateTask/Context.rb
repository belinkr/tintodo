# encoding: utf-8
require 'Tinto/Context'

module Tintodo
  module CreateTask
    class Context
      include Tinto::Context

      def initialize(arguments)
        @task           = arguments.fetch(:task)
        @tasks          = arguments.fetch(:tasks)
        @pending_tasks  = arguments.fetch(:pending_tasks)
      end #initialize

      def call
        tasks           .add task
        pending_tasks   .add task

        will_sync task, tasks, pending_tasks
      end #call

      private

      attr_reader :task, :tasks, :pending_tasks
    end # Context
  end # CreateTask
end # Tintodo

