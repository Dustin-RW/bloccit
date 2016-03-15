require 'rails_helper'

RSpec.describe Labeling, type: :model do

  #Shoulda gem, Labeling belongs to a labelable
  it { is_expected.to belong_to :labelable}


end
