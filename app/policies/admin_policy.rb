class AdminPolicy < ApplicationPolicy

  def edit?; user.id == record.id; end
  def update?; edit?; end

end