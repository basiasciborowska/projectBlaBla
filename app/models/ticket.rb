class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :title, :description, :priority, presence: true
end