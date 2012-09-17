class Array
  remove_method :length, :delete
end

class Array
  def length
    _length(0)
  end
  
  def _length(num)
    return 0 if self[num].nil?
    1 + _length(num+1)
  end
  
  def sigma
    _sigma(0)
  end
  
  def _sigma(index)
    return 0 if self[index].nil?
    self[index] + _sigma(index + 1)
  end

  def delete(value)
    _delete(value, 0)
  end
  
  def _delete(value, index)
    if self[index] == value
    end
  end
end
puts [1,2,3,4].length
puts [1,2,3,4].sigma
