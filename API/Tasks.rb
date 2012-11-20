# encoding: utf-8
require 'json'
require 'sinatra/base'
require 'redis'
require 'Tinto/Dispatcher'
require_relative '../Locales/Loader'
require_relative '../Data/Task/Presenter'

require_relative '../Cases/ListAllTasks/Request'
require_relative '../Cases/ListCompletedTasks/Request'
require_relative '../Cases/ListPendingTasks/Request'
require_relative '../Cases/CreateTask/Request'
require_relative '../Cases/CreateTask/Context'
require_relative '../Cases/UpdateTask/Request'
require_relative '../Cases/UpdateTask/Context'
require_relative '../Cases/DeleteTask/Request'
require_relative '../Cases/DeleteTask/Context'
require_relative '../Cases/CompleteTask/Request'
require_relative '../Cases/CompleteTask/Context'
require_relative '../Cases/UncompleteTask/Request'
require_relative '../Cases/UncompleteTask/Context'

$redis ||= Redis.new

module Tintodo
  class API < Sinatra::Base
    get '/tasks' do
      data = ListAllTasks::Request.new.prepare
      dispatch :collection do
        data.fetch(:tasks)
      end
    end # get /tasks

    post '/tasks' do
      data    = CreateTask::Request.new(payload).prepare
      task    = data.fetch(:task)

      dispatch :create, task do
        CreateTask::Context.new(data).run
        task
      end
    end # post /tasks

    put '/tasks/:id' do
      data          = UpdateTask::Request.new(payload: payload, params: params)
                        .prepare
      changed_task  = data.fetch(:changed_task)

      dispatch :update, changed_task do
        UpdateTask::Context.new(data).run
        changed_task
      end
    end # put /tasks

    delete '/tasks/:id' do
      data  = DeleteTask::Request.new(params).prepare
      task  = data.fetch(:task)

      dispatch :delete, task do
        DeleteTask::Context.new(data).run
        task
      end
    end

    put '/tasks/completed/:id' do
      data  = CompleteTask::Request.new(params).prepare
      task  = data.fetch(:task)

      dispatch :update, task do
        CompleteTask::Context.new(data).run
        task
      end
    end

    put '/tasks/pending/:id' do
      data  = UncompleteTask::Request.new(params).prepare
      task  = data.fetch(:task)

      dispatch :update, task do
        UncompleteTask::Context.new(data).run
        task
      end
    end

    get '/tasks/completed' do
      data = ListCompletedTasks::Request.new.prepare
      dispatch :collection do
        data.fetch(:completed_tasks)
      end
    end

    get '/tasks/pending' do
      data = ListPendingTasks::Request.new.prepare
      dispatch :collection do
        data.fetch(:pending_tasks)
      end
    end

    helpers do
      def dispatch(action, resource=nil, &block)
        Tinto::Dispatcher.new(nil, resource, &block).send(action)
      end #dispatch

      def payload
        JSON.parse(request.body.read.to_s)
      end #payload
    end
  end # API
end # Tintodo

