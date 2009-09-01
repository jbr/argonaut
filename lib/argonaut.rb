require 'json'
class Argonaut
  instance_methods.each {|m| undef_method(m) unless %w(__id__ __send__ to_json instance_eval).include?(m.to_s)}
  
  def initialize(&blk)
    @hash = {}
    blk.call(self)
  end
  
  def method_missing(key, *values)
    if block_given?
      @hash[key] = Argonaut.new {|a| yield a}
    else
      @hash[key] = values.size == 1 ? values.first : values
    end
  end
  
  def to_json() @hash.to_json end
  
  def to_s
    @hash.to_s
  end
  
  def inspect
    @hash.inspect
  end
end