# encoding: utf-8
require 'minitest/autorun'
require 'redis'
require_relative '../../../Cases/UncompleteTask/Request'

include Tintodo

$redis ||= Redis.new
$redis.select 8

describe UncompleteTask::Request do
  before do
    $redis.flushdb
  end

  describe '#initialize' do
    it 'requires a params' do
      lambda { UncompleteTask::Request.new }.must_raise ArgumentError
    end
  end #initialize

  describe '#prepare' do
    it 'returns a task as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      params  = { 'id' => task.id }
      data    = UncompleteTask::Request.new(params).prepare
      data.fetch(:task).must_be_instance_of Task::Member
    end

    it 'returns a collection of completed tasks as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      params  = { 'id' => task.id }
      data    = UncompleteTask::Request.new(params).prepare
      data.fetch(:completed_tasks).must_be_instance_of Task::Collection
      data.fetch(:completed_tasks).kind.must_equal 'completed'
    end

    it 'returns a collection of pending tasks as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      params  = { 'id' => task.id }
      data    = UncompleteTask::Request.new(params).prepare
      data.fetch(:pending_tasks).must_be_instance_of Task::Collection
      data.fetch(:pending_tasks).kind.must_equal 'pending'
    end
  end #prepare
end # UncompleteTask::Request

