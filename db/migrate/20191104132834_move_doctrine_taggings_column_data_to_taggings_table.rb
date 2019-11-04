class MoveDoctrineTaggingsColumnDataToTaggingsTable < ActiveRecord::Migration[5.2]
  class DoctrineTagging < ActiveRecord::Base
  end

  def change
    DoctrineTagging.find_each do |dt|
      new_tagging = Tagging.create(
        tag_id: dt.tag_id,
        tagable_type: 'Doctrine',
        tagable_id: dt.doctrine_id
      )
      new_tagging.save!
    end
  end
end
