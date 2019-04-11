class DoctrineTagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :doctrine
end
