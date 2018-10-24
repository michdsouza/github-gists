class Gist
  include ActiveModel::Model

  attr_accessor :id, :description, :filename, :content

  def initialize(id, description, filename, content)
    @id = id
    @description = description
    @filename = filename
    @content = content
  end

  def persisted?
    false
  end

end