# defining get_binding method that defines 1 instance variable, @ivar, and
# one local variable, lvar.  it then returns the binding context of the method.
class Demo
  def get_binding
    @ivar = 3
    lvar = "test"
    binding
  end
end

# calling eval twice to print out the instance and local variables that were
# stored in the binding context.
eval("puts @ivar", Demo.new.get_binding)
eval("puts lvar", Demo.new.get_binding)

