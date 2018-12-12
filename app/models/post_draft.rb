class PostDraft < ApplicationRecord

  belongs_to :post, optional: true, inverse_of: 'draft'

end