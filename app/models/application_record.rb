class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_error_messages
    errors.full_messages.join('. ')
  end

end
