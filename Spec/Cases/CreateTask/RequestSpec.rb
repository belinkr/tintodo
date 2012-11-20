# encoding: utf-8
require 'minitest/autorun'
require_relative '../../../Cases/CreateTask/Request'

include Tintodo

describe CreateTask::Request do
  describe '#initialize' do
    it 'requires a payload' do
      lambda { CreateTask::Request.new }.must_raise ArgumentError
    end
  end #initialize

  describe '#prepare' do
    it 'returns a task as a data object' do
      payload = {}
      data = CreateTask::Request.new(payload).prepare
      data.fetch(:task).must_be_instance_of Task::Member
    end

    it 'returns a collection of all tasks as a data object' do
      payload = {}
      data = CreateTask::Request.new(payload).prepare
      data.fetch(:tasks).must_be_instance_of Task::Collection
      data.fetch(:tasks).kind.must_equal 'all'
    end

    it 'returns a collection of pending tasks as a data object' do
      payload = {}
      data = CreateTask::Request.new(payload).prepare
      data.fetch(:pending_tasks).must_be_instance_of Task::Collection
      data.fetch(:pending_tasks).kind.must_equal 'pending'
    end
  end #prepare
end # CreateTask::Request

