require 'calorie'

describe Calorie::WeeksInMonth do
  let(:cal) { Calorie::WeeksInMonth.new }

  context "with a 28 day month" do
    before :each do
      allow(cal).to receive(:days_in_month) { 28 }
    end

    it "has 4 weeks when first day is Sunday" do
      allow(cal).to receive(:first_day_falls_on) { 0 }
      expect(cal.number_of_weeks).to eq(4)
    end

    it "has 5 weeks when first day is Monday" do
      allow(cal).to receive(:first_day_falls_on) { 1 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 5 weeks when first day is Saturday" do
      allow(cal).to receive(:first_day_falls_on) { 6 }
      expect(cal.number_of_weeks).to eq(5)
    end
  end

  context "with a 29 day month" do
    before :each do
      allow(cal).to receive(:days_in_month) { 29 }
    end

    it "has 5 weeks when first day is Sunday" do
      allow(cal).to receive(:first_day_falls_on) { 0 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 5 weeks when first day is Monday" do
      allow(cal).to receive(:first_day_falls_on) { 1 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 5 weeks when first day is Saturday" do
      allow(cal).to receive(:first_day_falls_on) { 6 }
      expect(cal.number_of_weeks).to eq(5)
    end

  end

  context "with a 30 day month" do
    before :each do
      allow(cal).to receive(:days_in_month) { 30 }
    end

    it "has 5 weeks when first day is Sunday" do
      allow(cal).to receive(:first_day_falls_on) { 0 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 5 weeks when first day is Friday" do
      allow(cal).to receive(:first_day_falls_on) { 5 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 6 weeks when first day is Saturday" do
      allow(cal).to receive(:first_day_falls_on) { 6 }
      expect(cal.number_of_weeks).to eq(6)
    end
  end

  context "with a 31 day month" do
    before :each do
      allow(cal).to receive(:days_in_month) { 31 }
    end

    it "has 5 weeks when first day is Sunday" do
      allow(cal).to receive(:first_day_falls_on) { 0 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 5 weeks when first day is Thursday" do
      allow(cal).to receive(:first_day_falls_on) { 4 }
      expect(cal.number_of_weeks).to eq(5)
    end

    it "has 6 weeks when first day is Friday" do
      allow(cal).to receive(:first_day_falls_on) { 5 }
      expect(cal.number_of_weeks).to eq(6)
    end

    it "has 6 weeks when first day is Saturday" do
      allow(cal).to receive(:first_day_falls_on) { 6 }
      expect(cal.number_of_weeks).to eq(6)
    end
  end

  context "when week starts on sunday" do
    before(:each) { Calorie.config = nil }

    describe "first day falls on" do
      {
        2003 => 2,
        2004 => 4,
        2005 => 5,
        2006 => 6,
        2007 => 0,
        2008 => 2
      }.each do |year, offset|
        it "#{offset} in April #{year}" do
          apr1 = Calorie::Day.new(Date.new(year, 4, 1))
          cal = Calorie::WeeksInMonth.new [apr1]
          expect(cal.first_day_falls_on).to eq(offset)
        end
      end
    end
  end

  context "when week starts on monday" do
    before :each do
      Calorie.configuration do |config|
        config.week_starts_on :monday
      end
    end

    describe "first day falls on" do
      {
        2003 => 3,
        2004 => 5,
        2005 => 6,
        2006 => 0,
        2007 => 1,
        2008 => 3
      }.each do |year, offset|
        it "#{offset} in May #{year}" do
          may1 = Calorie::Day.new(Date.new(year, 5, 1))
          cal = Calorie::WeeksInMonth.new [may1]
          expect(cal.first_day_falls_on).to eq(offset)
        end
      end
    end
  end

end
