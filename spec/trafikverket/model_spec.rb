require 'spec_helper'
require 'date'

describe Trafikverket::Examination do

  subject do
    Trafikverket::Examination
  end

  it "get week difference" do
    expect(subject.new("driving", (Date.today+6).to_s, "10:00:00", "stockholm").in_weeks).to eq 1
    expect(subject.new("driving", (Date.today+8).to_s, "10:00:00", "stockholm").in_weeks).to eq 2
    expect(subject.new("driving", (Date.today+15).to_s, "10:00:00", "stockholm").in_weeks).to eq 3
  end

end
