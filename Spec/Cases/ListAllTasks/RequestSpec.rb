# encoding: utf-8
require 'minitest/autorun'
require 'redis'
require_relative '../../../Cases/ListAllTasks/Request'

include Tintodo

$redis = Redis.new
$redis.select 8

describe ListAllTasks::Request do
  before do
    $redis.flushdb
  end

  describe '#prepare' do
    it 'returns request data with a collection of all tasks' do
      request = ListAllTasks::Request.new
      data    = request.prepare

      data.keys.must_include :tasks

      tasks = data.fetch(:tasks)
      tasks.must_be_instance_of Task::Collection
      tasks.kind.must_equal 'all'
    end
  end #prepare
end # ListAllTasks::Request

