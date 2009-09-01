require 'json'
class Argonaut
  instance_methods.each {|m| undef_method(m) unless %w(__id__ __send__ to_json to_xml instance_eval nil? is_a? class).include?(m.to_s)}
  
  def initialize(&blk)
    @hash = {}
    blk.call(self)
  end
  
  def method_missing(key, *values)
    value = if block_given?
      Argonaut.new {|a| yield a}
    else
      values.size == 1 ? values.first : values
    end
    
    if @hash[key].nil?
      @hash[key] = value
    elsif @hash[key].is_a? Array
      @hash[key] << value
    else
      @hash[key] = [@hash[key], value]
    end
  end
  
  def respond_to?(method) true end
  def to_xml(options = {}) @hash.to_xml(options) end
  def to_json() @hash.to_json end
  def to_s() @hash.to_s end
  def inspect() @hash.inspect end
end