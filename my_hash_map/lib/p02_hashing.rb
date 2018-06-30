class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    self.each do |el| 
      result += el.is_a?(String) ? el.ord.to_s(2) : el.to_s(2)
    end
    result.to_i.hash
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = ""
    sorted = self.sort_by{|k,v| k}.to_h
    sorted.each do |k,v|
      if k.is_a?(Symbol)
        k = k.to_s
      end
      result += k.is_a?(String) ? k.ord.to_s(2) : k.to_s(2)
      result += v.is_a?(String) ? v.ord.to_s(2) : v.to_s(2)
    end
    result.to_i.hash
  end
end
