require 'spec_helper'

describe Trafikverket::BokaForm do

  subject do
    Trafikverket::BokaForm.new
  end

  describe "#get_person_id" do
    it "parse person_id from a string which does't contain '-'" do
      expect(subject.get_person_id "201701019191").to eq "20170101-9191"
    end
  end

end
