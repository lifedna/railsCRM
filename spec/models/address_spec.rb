require 'spec_helper'

describe Address do

  it {should be_embedded_in(:lead).as_inverse_of(:addresses)}

end
