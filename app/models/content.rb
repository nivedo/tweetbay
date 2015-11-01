class Content < ActiveRecord::Base
  has_ancestry
  has_one :image, dependent: :destroy
  
  before_save { |content| content.title = title.titleize }

  default_scope { order('created_at') }

  validates :description, presence: true

  belongs_to :user

  def permitted_actions(myuser)
    action_list = []
    if myuser == user
      action_list << :edit
      action_list << :delete
    else
      unless ancestry?
        action_list << :report
        action_list << :thank
      end
    end
    return action_list
  end
end
