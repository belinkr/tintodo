# encoding: utf-8
require_relative '../../Data/Task/Member'
require_relative '../../Data/Task/Collection'

module Tintodo
  module DeleteTask
    class Request
      def initialize(params)
        @params = params
      end # initialize

      def prepare
        task            = Task::Member.new(id: params.fetch('id')).fetch
        tasks           = Task::Collection.new(kind: 'all')
        pending_tasks   = Task::Collection.new(kind: 'pending')
        completed_tasks = Task::Collection.new(kind: 'completed')

        {   
          task:             task, 
          tasks:            tasks,
          pending_tasks:    pending_tasks,
          completed_tasks:  completed_tasks
        }
      end #prepare

      private

      attr_reader :params
    end # Request
  end # DeleteTask
end # Tintodo

