class PostDraft < ApplicationRecord

  belongs_to :post, optional: true, inverse_of: 'draft'

  def publish
    _post = self.post
    if _post
      destroy and return true if _post.update(title: title, content: content)
    else
      destroy and return true if self.build_post(title: title, content: content, admin_id: admin_id).save
    end
    false
  end

end