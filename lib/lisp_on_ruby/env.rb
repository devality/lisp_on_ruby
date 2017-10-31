class Env

  def initialize(frame = {}, parent = nil)
    @frame = frame
    @parent = parent
  end

  def get(binding_name)
    value = @frame[binding_name]
    return value unless value.nil?
    return binding_name if @parent.nil?

    @parent.get(binding_name)
  end

  def set(binding_name, value)
    existed = !@frame[binding_name].nil?
    if existed
      @frame[binding_name] = value
    else
      @parent.set(binding_name, value)
    end
  end

  def define(binding_name, value)
    @frame[binding_name] = value
  end
end
