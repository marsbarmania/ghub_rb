class Task
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :active, Boolean, :default => true
  key :published_at, Time
  timestamps! # define created_at, updated_at

  validates_presence_of :title
  validates_presence_of :body
  validates :title, :length => {:minimum => 1}
  validates :body, :length => {:minimum => 1}

end
