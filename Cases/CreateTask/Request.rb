# encoding: utf-8
require_relative '../../Data/Task/Collection'
require_relative '../../Data/Task/Member'

module Tintodo
  module CreateTask
    class Request
      def initialize(payload)
        @payload = payload
      end # initialize

      def prepare
        {
          task:           Task::Member.new(payload),
          tasks:          Task::Collection.new(kind: 'all'),
          pending_tasks:  Task::Collection.new(kind: 'pending')
        }
      end #prepare

      private

      attr_reader :payload
    end # Request
  end # CreateTask
end # Tintodo

