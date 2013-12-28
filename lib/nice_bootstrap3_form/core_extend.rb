# encoding: utf-8
class Array
  def compact_squish_join(separator = ' ')
    flatten.uniq.compact.join(separator).gsub(/  /, ' ').gsub(/^ /, '').gsub(/ $/, '')
  end
end

class Object
  def false?
    self.is_a? FalseClass || self
  end
end
