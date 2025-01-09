class Recommendation
  attr_reader: name, short_description, img_url
  
  def initializer(attributes)
    @name = attributes[:name]
    @short_description = attributes[:short_description]
    @img_url = attributes[:img_url]
  end
end