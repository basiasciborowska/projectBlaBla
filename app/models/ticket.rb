class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  validates :title, :description, :priority, presence: true
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :picture, :matches => [/gif\Z/, /png\Z/, /jpe?g\Z/, /doc\Z/, /xls\Z/, /ppt\Z/]
  validates_with AttachmentSizeValidator, :attributes => :picture, :less_than => 1.megabytes
  attr_accessor :remove_picture
  
  before_save :delete_picture, if: ->{ remove_picture == '1' && !picture_updated_at_changed? }
  
  private
    def delete_picture
      self.picture = nil
    end
end
