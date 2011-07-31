require "spec_helper"

describe Lead do

  it {should validate_presence_of :name}
  it {should validate_presence_of :source}


  it {should be_referenced_in :organisation}
  it {should embed_many :addresses}
  it {should embed_many :contacts}


end
