RSpec.shared_examples 'a day' do
  context "during the weekend" do
    let(:jan_13) { Date.new(2010, 6, 13) }
    let(:day) { described_class.new(jan_13, "hello, world") }

    it { expect(day.number).to eq(13) }
    it { expect(day.data).to eq("hello, world") }
    it { expect(day.weekend?).to be true }
    it { expect(day.blank?).to be false }
    it { expect(day.date).to eq(jan_13) }

    context "on that particular day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 13, 11, 40, 17))
      end

      after :each do
        Timecop.return
      end

      it { expect(day.today?).to be true }
    end

    context "on a different day" do
      before :each do
        Timecop.freeze(Time.new(2010, 6, 14, 20, 15, 47))
      end

      after :each do
        Timecop.return
      end

      it { expect(day.today?).to be false }
    end
  end

  context "midweek" do
    let(:jan_17) { Date.new(2010, 6, 17) }
    let(:day) { described_class.new(jan_17, "so long, folks") }

    it { expect(day.number).to eq(17) }
    it { expect(day.data).to eq("so long, folks") }
    it { expect(day.weekend?).to be false }
    it { expect(day.blank?).to be false}
    it { expect(day.date).to eq(jan_17) }
  end
end
