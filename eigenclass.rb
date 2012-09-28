class BasicObject
  def ghost
    class << self # going into the ghost class of the object self
      self # now that we're in the ghost class return it to the caller
    end
  end
end
