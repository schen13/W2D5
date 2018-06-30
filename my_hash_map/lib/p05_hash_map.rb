require "byebug"
require_relative 'p04_linked_list'
require_relative 'p02_hashing'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if count >= num_buckets
    if self.include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    check = @store[bucket(key)].remove(key)
    @count -= 1 if check
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  
  attr_accessor :store
  
  def num_buckets
    @store.length
  end

  def resize!
    # new_arr = HashMap.new(num_buckets * 2)
    # @store.each_with_index do |list, i|
    #   list.each do |node|
    #     new_arr.store[new_arr.bucket(node.key)].append(node.key, node.value)
    #   end
    # end
    # @store = new_arr
  end

  def bucket(key)
    if key.is_a?(Symbol)
      key = key.to_s.chars
    end
    number = 0
    key.each { |ch| number += ch.ord }
    number % num_buckets
  end
end
