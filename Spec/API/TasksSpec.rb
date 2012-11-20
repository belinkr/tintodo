# encoding: utf-8
require 'minitest/autorun'
require 'rack/test'
require 'json'
require 'redis'
require_relative '../../API/Tasks'

$redis = Redis.new
$redis.select 8

describe 'tasks HTTP API' do
  include Rack::Test::Methods
  def app; Tintodo::API.new; end

  before do
    $redis.flushdb
  end

  describe 'GET /tasks' do
    it 'retrieves all tasks' do
      3.times do |i|
        task = { name: "task #{i}" }
        post '/tasks', task.to_json
      end

      get '/tasks'
      last_response.status.must_equal 200

      tasks_data  = JSON.parse(last_response.body)
      sample_task = tasks_data.first
      
      tasks_data.length   .must_equal 3
      sample_task.keys    .must_include('id')
      sample_task.keys    .must_include('name')
    end
  end # GET /tasks

  describe 'POST /tasks' do
    it 'creates a new task' do
      task = { name: 'task 1' }
      post '/tasks', task.to_json

      last_response.status.must_equal 201
      task_data = JSON.parse(last_response.body)

      task_data.fetch('id')   .wont_be_nil
      task_data.fetch('name') .must_equal task.fetch(:name)

      get '/tasks'
      last_response.status    .must_equal 200
      tasks_data = JSON.parse(last_response.body)
      tasks_data.length       .must_equal 1

      sample_task = tasks_data.first
      sample_task.fetch('id') .must_equal task_data.fetch('id')
    end
  end # POST /tasks

  describe 'PUT /tasks/:id' do
    it 'updates the name of the task' do
      task = { name: 'task 1' }
      post '/tasks', task.to_json

      task_data = JSON.parse(last_response.body)
      task_url  = task_data.fetch('links').fetch('self')

      put task_url, { name: 'updated task 1' }.to_json
      last_response.status.must_equal 200

      updated_task_data = JSON.parse(last_response.body)
      updated_task_data.fetch('id')   .must_equal task_data.fetch('id')
      updated_task_data.fetch('name') .must_equal 'updated task 1'
    end
  end # PUT /tasks/:id

  describe 'DELETE /tasks/:id' do
    it 'deletes the tasks' do
      task = { name: 'task 1' }
      post '/tasks', task.to_json

      task_data = JSON.parse(last_response.body)
      task_url  = task_data.fetch('links').fetch('self')

      delete task_url
      last_response.status.must_equal 204

      get task_url
      last_response.status.must_equal 404
    end
  end # DELETE /tasks/:id

  describe 'GET /tasks/pending' do
    it 'retrieves all pending tasks' do
      3.times do |i|
        task = { name: "task #{i}" }
        post '/tasks', task.to_json
      end

      get '/tasks/pending'
      last_response.status.must_equal 200

      pending_tasks_data  = JSON.parse(last_response.body)
      sample_task         = pending_tasks_data.first
      
      pending_tasks_data.length   .must_equal 3
      pending_tasks_data.each { |task_data|
        task_data.fetch('state').must_equal 'pending'
      }
    end
  end # GET /tasks/pending

  describe 'GET /tasks/completed' do
    it 'retrieves all completed tasks' do
      3.times do |i|
        task = { name: "task #{i}" }
        post '/tasks', task.to_json

        task_data     = JSON.parse(last_response.body)
        complete_url  = task_data.fetch('links').fetch('complete')
        put complete_url
      end

      get '/tasks/completed'
      last_response.status.must_equal 200

      completed_tasks_data  = JSON.parse(last_response.body)
      sample_task           = completed_tasks_data.first
      
      completed_tasks_data.length .must_equal 3
      completed_tasks_data.each { |task_data|
        task_data.fetch('state').must_equal 'completed'
      }
    end
  end # GET /tasks/completed

  describe 'PUT /tasks/completed/:id' do
    it 'marks a task as completed' do
      task = { name: 'task 1' }
      post '/tasks', task.to_json

      task_data     = JSON.parse(last_response.body)
      complete_url  = task_data.fetch('links').fetch('complete')
      
      put complete_url
      task_data = JSON.parse(last_response.body)
      task_data.fetch('state').must_equal 'completed'
    end
  end # PUT /tasks/completed/:id

  describe 'PUT /tasks/pending/:id' do
    it 'marks a task as pending' do
      task = { name: 'task 1' }
      post '/tasks', task.to_json

      task_data       = JSON.parse(last_response.body)
      uncomplete_url  = task_data.fetch('links').fetch('complete')

      put uncomplete_url
      task_data = JSON.parse(last_response.body)
      task_data.fetch('state').must_equal 'completed'

      put task_data.fetch('links').fetch('uncomplete')

      task_data = JSON.parse(last_response.body)
      task_data.fetch('state').must_equal 'pending'
    end
  end # PUT /tasks/pending/:id
end # tasks HTTP API

