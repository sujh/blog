class PostPolicy < ApplicationPolicy

  def new?; true; end

  def show?
    user.id == record.admin_id
  end

  def create?
    user.id == record.admin_id
  end

  def edit?; create?; end
  def update?; edit?; end
  def destroy?; create?; end

end