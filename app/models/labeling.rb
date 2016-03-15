class Labeling < ActiveRecord::Base
  #we stipulate that Labeling is polymorhic and that it can mutate into different types of objects through labelable
  belongs_to :labelable, polymorphic: true

  belongs_to :label

end
