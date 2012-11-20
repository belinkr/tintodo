# encoding: utf-8
require 'minitest/autorun'
require 'ostruct'
require_relative '../../../Cases/UpdateTask/Context'

include Tintodo

describe UpdateTask::Context do
  it 'updates the task' do
    task          = Minitest::Mock.new
    changed_task  = OpenStruct.new(attributes: { name: 'changed' })
    context       = UpdateTask::Context.new(
      task:         task,
      changed_task: changed_task
    )

    task.expect :update, nil, [{ name: 'changed' }]
    context.call
    task.verify
  end
end # UpdateTask::Context

