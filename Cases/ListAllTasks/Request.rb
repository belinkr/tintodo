# encoding: utf-8
require_relative '../../Data/Task/Collection'

module Tintodo
  module ListAllTasks
    class Request
      def initialize
        @tasks = Task::Collection.new(kind: 'all')
      end #initialize

      def prepare
        tasks.fetch
        { tasks: tasks }
      end #prepare

      private

      attr_reader :tasks
    end # Request
  end # ListAllTasks
end # Tintodo

