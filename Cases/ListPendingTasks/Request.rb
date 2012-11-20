# encoding: utf-8
require_relative '../../Data/Task/Collection'

module Tintodo
  module ListPendingTasks
    class Request
      def initialize
        @pending_tasks = Task::Collection.new(kind: 'pending')
      end #initialize

      def prepare
        pending_tasks.fetch
        { pending_tasks: pending_tasks }
      end #prepare

      private

      attr_reader :pending_tasks
    end # Request
  end # ListPendingTasks
end # Tintodo

