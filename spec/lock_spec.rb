require 'lock'

describe Lock do
  subject { Lock.new(params) }

  describe '#open' do
    context 'with simple and right params' do
      let!(:params) { { from: [0, 0, 0, 0], to: [0, 0, 0, 1] } }
      it 'verifies that print something to output' do
        expect { subject.open }.to output.to_stdout
      end

      let!(:params) { { from: [0, 0, 0, 0], to: [0, 1, 0, 0] } }
      it 'verifies that print correct output' do
        test_output = /[0, ][0, 1]/
        expect { subject.open }.to output(test_output).to_stdout
      end
    end

    context 'with more hardest params' do
      let!(:params) { { from: [0, 0, 1, 0], to: [1, 1, 1, 0] } }
      test_output = /[0, 1][1, 0][1, 0]/
      it 'verifies that print correct output' do
        expect { subject.open }.to output(test_output).to_stdout
      end

      let!(:params) { { from: [0, 0, 1, 0], to: [1, 1, 1, 1], exclude: [[0, 1, 1, 0]] } }
      test_output = /[0, 1][1, 0][1, 0][1, ]/
      it 'verifies that print correct output with exclude' do
        expect { subject.open }.to output(test_output).to_stdout
      end
    end

    context 'something went wrong' do
      let!(:params) { { from: [0, 0, 1, 0], to: [1, 1, 1, 1], exclude: [[0, 1, 1, 0], [0, 0, 1, 0]] } }
      it 'with exclude when cannot be done' do
        expect { subject.open }.to raise_error(/There is no solution for given params/)
      end

      let!(:params) { { from: [], to: [], exclude: [] } }
      it 'show error when from or to is empty' do
        expect { subject.open }.to raise_error(/From or to cannot be empty/)
      end

      let!(:params) { {} }
      it 'show error when from or to is empty' do
        expect { subject.open }.to raise_error(/You need set from and to values/)
      end
    end
  end
end
