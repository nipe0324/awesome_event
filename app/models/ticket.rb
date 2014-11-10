class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :comment, length: { miximum: 30 }, allow_blank: true
end
