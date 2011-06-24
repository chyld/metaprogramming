# dynamically adding validation and accessor attributes to a class
#
# defining one instance method, errors, that will be included as an
# instance method in the User class.  also defining a hook method
# self.included that gets called automatically when this module
# gets included into a class.  this hook method contains the name
# of the class that included the module.  using the class << klass
# notation allows us to access the eigenclass of the User class,
# effectively adding a class method, add_custom_attributes, to User.
# so, by including this module in the User class, it adds one
# instance method, errors, and one class method, add_custom_attributes.
module CustomAttributes
  def self.included(klass)
    class << klass
      def add_custom_attribute(var, msg, &validation)
        define_method var do
          instance_variable_get "@#{var}"
        end

        define_method "#{var}=" do |new_value|
          instance_variable_set "@#{var}", new_value
          errors[var] = msg if validation.call(new_value)
        end
      end
    end
  end

  def errors
      @errors ||= {}
  end
end

# becasue add_custom_attrbutes was added as a class method (see above) we
# can now call it as many times as we want.  once for every attribute that
# we want to add to this class.  in this example we are adding 3 attributes
# which translates into 6 accessor methods.
class User
  include CustomAttributes

  add_custom_attribute(:name, "Minimum of 5 characters") { |x| x.length < 5  }
  add_custom_attribute(:age, "Must be at least 18") { |x| x < 18  }
  add_custom_attribute(:weight, "Must be over 100 lbs") { |x| x < 100  }
end

# in this example, 2 of the 3 attributes failed validity testing.
u = User.new
u.name = "me"
u.age = 22
u.weight = 77

u.errors.each do |k,v|
  puts "#{k} -> #{v}"
end

