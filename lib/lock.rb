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

    print_output(build_array_of_possibilites.map! { |e| e.chars.map(&:to_i) })
  end
 
  private

  def build_array_of_possibilites
    res = []
    res << @from.join
    i = 0

    until @from == @to
      break @break = true if i > @from.size**3

      if @from[i] == @to[i]
        i += 1
        next
      end

      @from[i] = @to[i] unless @exclude.include?(@from)
      res << @from.join
      i += 1
    end
    res
  end

  def print_output(output)
    raise 'There is no solution for given params' if @break

    output.each{ |array| p array}
  end
end
#Lock.new(from: [], to:[], exclude: []).open