require 'calorie/day'
require 'support/shared_examples/a_day'
require 'timecop'

describe Calorie::Day do
  let(:day) { Calorie::Day.new(Date.new(2010, 6, 13), "hello, world") }

  it_behaves_like 'a day'
  it { expect(day.padding?).to be false }
end

describe Calorie::PaddingDay do
  let(:day) { Calorie::PaddingDay.new(Date.new(2010, 1, 1), 'hello world') }

  it { expect(day.padding?).to be true }

  context 'when show_padding_days config is on' do
    before do
      Calorie.configuration.show_padding_days true
    end

    after do
      Calorie.configuration.show_padding_days false
    end

    it_behaves_like 'a day'
  end

  context 'when show_padding_days config is off' do
    before do
      Calorie.configuration.show_padding_days false
    end

    it { expect(day.number).to be nil }
    it { expect(day.blank?).to be true }
  end
end
