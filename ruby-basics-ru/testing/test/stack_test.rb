# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def test_that_element_is_added
    stack = @stack
    stack.push!('test')
    assert { stack.to_a == ['test'] }
    assert { stack.size == 1 }
    assert { !stack.empty? }
  end

  def test_that_element_is_deleted
    stack = @stack
    stack.push!('test_1')
    stack.push!('test_2')
    assert { stack.size == 2 }
    stack.pop!
    assert { stack.size == 1 }
  end

  def test_that_stack_is_cleared
    stack = @stack
    stack.push!('test')
    assert { stack.empty? == false }
    stack.clear!
    assert { stack.empty? == true }
  end

  def test_that_stack_is_empty
    stack = @stack
    assert { stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
