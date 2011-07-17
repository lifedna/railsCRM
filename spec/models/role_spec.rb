require 'spec_helper'

describe Role do

  it { should be_embedded_in(:user).as_inverse_of :role}


end
