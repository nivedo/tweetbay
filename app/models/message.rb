class Message < ActiveRecord::Base
  belongs_to :group

  has_one :content, dependent: :destroy
  accepts_nested_attributes_for :content
end
