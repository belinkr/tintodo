# encoding: utf-8
require 'Tinto/Context'

module Tintodo
  module UpdateTask
    class Context
      include Tinto::Context

      def initialize(arguments)
        @task         = arguments.fetch(:task)
        @changed_task = arguments.fetch(:changed_task)
      end #initialize

      def call
        task.update(changed_task.attributes)
        will_sync task
      end #call

      private

      attr_reader :task, :changed_task
    end # Context
  end # UpdateTask
end # Tintodo

