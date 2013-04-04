class Hash

  # Will discard all blank values from the hash.
  #
  # Example:
  #   { bob: "foo", bing: "" } # => { bob: "foo" }
  #
  def compact
    self.select{|k,v| !v.blank? }
  end
end
