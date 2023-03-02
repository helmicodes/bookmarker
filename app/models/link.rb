class Link < ApplicationRecord
  scope :with_name, ->(title) {
    where("lower(title) LIKE ? OR lower(url) LIKE ?", "%#{title.downcase}%", "%#{title.downcase}%") if title.present?
  }

  scope :with_category, ->(category) {
    where(category: category) if category.present?
  }

  def self.search(params={})
    self.with_name(params[:title])
        .with_category(params[:category])
        .order(created_at: :desc)
  end
end
