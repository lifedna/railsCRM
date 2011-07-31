require 'spec_helper'

describe Contact do

  it {should be_embedded_in(:lead).as_inverse_of(:contacts)}

end
