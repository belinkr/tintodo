# encoding: utf-8
require 'minitest/autorun'
require 'redis'
require_relative '../../../Cases/DeleteTask/Request'

include Tintodo

$redis ||= Redis.new
$redis.select 8

describe DeleteTask::Request do
  before { $redis.flushdb }

  describe '#initialize' do
    it 'requires a params hash' do
      lambda { DeleteTask::Request.new      }.must_raise ArgumentError
    end
  end #initialize

  describe '#prepare' do
    it 'returns a task as a data object' do
      task    = Task::Member.new(name: 'task 1').sync
      params  = { 'id'    => task.id }
      data    = DeleteTask::Request.new(params).prepare

      data.fetch(:task).must_be_instance_of Task::Member
    end
  end #prepare
end # DeleteTask::Request

