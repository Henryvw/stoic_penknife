class QuotationTagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :quotation
end
