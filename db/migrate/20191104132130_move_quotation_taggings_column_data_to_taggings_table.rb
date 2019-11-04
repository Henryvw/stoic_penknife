class MoveQuotationTaggingsColumnDataToTaggingsTable < ActiveRecord::Migration[5.2]
  def change
    QuotationTagging.find_each do |qt|
      new_tagging = Tagging.create(
        tag_id: qt.tag_id,
        tagable_type: 'Quotation',
        tagable_id: qt.quotation_id
      )
      new_tagging.save!
    end
  end
end
