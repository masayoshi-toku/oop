class Category < ApplicationRecord
  ARTICLE_LABEL_IDS = 1..3
  def self.article_checkboxes
    where(id: ARTICLE_LABEL_IDS).inject({}) { |hash, record| hash[record.id] = record.name; hash }
  end
end
