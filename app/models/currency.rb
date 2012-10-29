class Currency
  attr_reader :code, :name, :rate

  def initialize(code, name, rate)
    @code = code
    @name = name
    @rate = rate
  end

  def initWithCoder(coder)
    @name = coder.decodeObjectForKey("name")
    @code = coder.decodeObjectForKey("code")
    @rate = coder.decodeDoubleForKey("rate")

    self
  end

  def encodeWithCoder(coder)
    coder.encodeObject(name, forKey:"name")
    coder.encodeDouble(rate, forKey:"rate")
    coder.encodeObject(code, forKey:"code")
  end

  def match?(regex)
    regex.match(name) || regex.match(code)
  end
end
