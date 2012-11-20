# encoding: utf-8
require_relative '../../Data/Task/Member'

module Tintodo
  module UpdateTask
    class Request
      def initialize(arguments)
        @params   = arguments.fetch(:params)
        @payload  = arguments.fetch(:payload)
      end # initialize

      def prepare
        task          = Task::Member.new(id: params.fetch('id')).fetch
        changed_task  = Task::Member.new(payload.merge(id: task.id))

        {
          task:         task,
          changed_task: changed_task
        }
      end #prepare

      private

      attr_reader :payload, :params
    end # Request
  end # UpdateTask
end # Tintodo

