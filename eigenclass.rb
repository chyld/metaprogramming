# the eigenclass instance method on Object will now be inherited by all classes
class Object
  def eigenclass
    class << self
      self
    end
  end
end

# displays the eigenclass for the string object
s = String.new
puts s.eigenclass

# displays the eigenclass for the String class object
puts String.eigenclass

