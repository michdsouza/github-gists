class Gist
  include ActiveModel::Model

  attr_accessor :id, :description, :filename, :content

  def initialize(id, description = nil, filename = nil, content = nil)
    @id = id
    @description = description
    @filename = filename
    @content = content
  end

  def persisted?
    false
  end

end