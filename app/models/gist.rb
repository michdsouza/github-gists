class Gist
  include ActiveModel::Model

  attr_accessor :description, :filename, :content

  def persisted?
    false
  end

end