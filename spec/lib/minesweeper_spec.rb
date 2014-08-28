require_relative '../../lib/minesweeper'

describe Minesweeper do
  subject { Minesweeper.new(input)}

  context 'empty board' do
    let (:input) { '0 0' }

    it 'should return empty string' do
      expect(subject.generate).to eq("")
    end
  end

  context '1x1 board' do
    context 'with bomb' do
      let (:input) { "1 1\n*" }

      it { expect(subject.generate).to eq('*') }
    end

    context 'without bomb' do
      let (:input) { "1 1\n." }

      it { expect(subject.generate).to eq('0') }
    end
  end

  context '2x1 board' do
    context 'without bomb' do
      let (:input) { "2 1\n.\n."}

      it {expect(subject.generate).to eq("0\n0")}
    end
    context 'with bomb' do
      let (:input) { "2 1\n*\n."}

      it {expect(subject.generate).to eq("*\n1")}
    end
  end
end