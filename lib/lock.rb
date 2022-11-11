require 'bundler/setup'
Bundler.require

class Lock
  attr_reader :from, :to, :exclude

  def initialize(args)
    @from = args[:from]
    @to = args[:to]
    args[:exclude] ||= []
    @exclude = args[:exclude]
  end

  def open
    raise 'You need set from and to values' if @from.nil? || @to.nil?
    raise 'From or to cannot be empty' if @from.empty? || @to.empty?
    raise 'Wrong array size for from or to params' if @from.size != @to.size

    print_output(build_array_of_possibilites)
  end

  private

  def build_array_of_possibilites
    res = []
    res << @from.dup
    i = 1
    it = 0

    until @from == @to
      break @break = true if i > @from.size**3

      it = 0 if (i % @from.size).zero?
      tmp_arr = @from.dup

      if @from[it] == @to[it]
        i += 1
        it += 1
        next
      end

      tmp_arr[it] = @to[it]
      unless @exclude.include?(tmp_arr)
        @from[it] = @to[it]
        res << @from.dup
      end
      it += 1
      i += 1
    end
    res
  end

  def print_output(output)
    raise 'There is no solution for given params' if @break

    output.each { |array| p array }
  end
end
#Lock.new(from: [0, 0, 0], to: [1, 1, 1], exclude: [[0, 0, 1], [1, 0, 0]]).open
