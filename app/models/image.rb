class Image < ActiveRecord::Base
  belongs_to :content

  mount_uploader :attachment, AttachmentUploader
end
