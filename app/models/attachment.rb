class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  mount_uploader :content, AttachmentUploader
  
  after_destroy :delete_linked_file

  def delete_linked_file
    remove_content!
  end
  
end
