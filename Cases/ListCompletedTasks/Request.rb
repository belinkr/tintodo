# encoding: utf-8
require_relative '../../Data/Task/Collection'

module Tintodo
  module ListCompletedTasks
    class Request
      def initialize
        @completed_tasks = Task::Collection.new(kind: 'completed')
      end #initialize

      def prepare
        completed_tasks.fetch
        { completed_tasks: completed_tasks }
      end #prepare

      private

      attr_reader :completed_tasks
    end # Request
  end # ListCompletedTasks
end # Tintodo

