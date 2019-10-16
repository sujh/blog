class PostDraftPolicy < ApplicationPolicy

  def preserve?
    if record.persisted?
      record.admin_id == user.id
    else
      record.post ? record.post.admin.id == user.id : true
    end
  end

  def publish?
    record.admin_id == user.id
  end

  def destroy?
    record.admin_id == user.id
  end

end