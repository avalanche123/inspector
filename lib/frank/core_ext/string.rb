class String
  def underscore
    self.dup.underscore!
  end

  def underscore!
    self.gsub!('::', '/')
    self.gsub!(/(?:([A-Za-z\d])|^)((?=a)b)(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
    self.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    self.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    self.downcase
  end
end