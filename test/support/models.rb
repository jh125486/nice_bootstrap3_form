class Article
  include ActiveModel::Model
  VALID_CLASSIFICATION_LEVELS = ['Unclass', 'Secret', 'Top Secret']

  attr_accessor :title, :paragraphs, :classification_level, :caveats, :compartments
  validates :title, :classification_level, presence: true

  def new_record!
    @new_record = true
  end

  def persisted?
    !@new_record
  end
end

class Paragraph
  include ActiveModel::Model

  VALID_CLASSIFICATION_LEVELS = ['Unclass', 'Secret', 'Top Secret']

  attr_accessor :classification_level, :caveats, :compartments, :body
  validates :classification_level, :body, presence: true
end
