# encoding: utf-8
require 'minitest/autorun'
require 'redis'
require_relative '../../../Cases/UpdateTask/Request'

include Tintodo

$redis ||= Redis.new
$redis.select 8

describe UpdateTask::Request do
  before { $redis.flushdb }

  describe '#initialize' do
    it 'requires a payload and params' do
      lambda { UpdateTask::Request.new      }.must_raise ArgumentError
      lambda { UpdateTask::Request.new({})  }.must_raise KeyError
    end
  end #initialize

  describe '#prepare' do
    it 'returns a task as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      payload = { 'name'  => 'changed' }
      params  = { 'id'    => task.id }
      data    = UpdateTask::Request.new(payload: payload, params: params)
                  .prepare

      data.fetch(:task).must_be_instance_of Task::Member
    end

    it 'returns a changed task as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      payload = { 'name'  => 'changed' }
      params  = { 'id'    => task.id }
      data    = UpdateTask::Request.new(payload: payload, params: params)
                  .prepare

      data.fetch(:changed_task)         .must_be_instance_of Task::Member
      data.fetch(:changed_task).name    .must_equal 'changed'
    end
  end #prepare
end # UpdateTask::Request

