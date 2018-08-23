class Article < ApplicationRecord
  has_many :articles_categories
  has_many :categories, through: :articles_categories

  validates :title, presence: true

  def form_params
    {
      title: title,
      body: body,
      category1: category_ids.include?(1) ? 1 : 0,
      category2: category_ids.include?(2) ? 1 : 0,
      category3: category_ids.include?(3) ? 1 : 0
    }
  end
end
