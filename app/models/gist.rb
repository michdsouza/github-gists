class Gist
  include ActiveModel::Model

  attr_accessor :id, :description, :filename, :content

  def persisted?
    false
  end

end