class Image < ActiveRecord::Base
  belongs_to :user
  attr_accessor :file

  before_create :save_file_info
  after_create :save_file
  before_destroy :destroy_file

  validates :user, presence: true
  validates :file, presence: true

  def save_file_info
    self.filetype = file.content_type
    self.filename = file.original_filename
    self.filesize = file.size
    self
  end

  def save_file
    self
  end

  def destroy_file
    self
  end

end
