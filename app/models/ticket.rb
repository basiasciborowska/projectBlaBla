class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :title, :description, :priority, presence: true
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :picture, :matches => [/gif\Z/, /png\Z/, /jpe?g\Z/, /doc\Z/, /xls\Z/, /ppt\Z/]
  validates_with AttachmentSizeValidator, :attributes => :picture, :less_than => 1.megabytes
end
