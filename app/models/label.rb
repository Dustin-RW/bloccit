class Label < ActiveRecord::Base
  #associate a label with many labelings
  has_many :labelings
  #label has many topics through the labeling table.
  has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
  #label has many posts through the labeling table.
  has_many :posts, through: :labelings, source: :labelable, source_type: :Post

  def self.update_labels( label_string )

    return Label.none if label_string.blank?

    label_string.split(",").map { |label| Label.find_or_create_by(name: label.strip)}

  end
end
