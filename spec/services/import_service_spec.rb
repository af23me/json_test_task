# frozen_string_literal: true

RSpec.describe ImportService do

  let(:service) { described_class.new(timestamp:) }
  let(:timestamp) { 'success_123' }

  describe '#run' do
    subject(:perform_method) { service.run }

    context 'when valid' do
      it 'should be sucessful' do
        expect(perform_method).to eq(true)
      end

      context 'check file content' do
        let(:example_content) { File.read('spec/fixtures/example_output.txt') }
        let(:expected_content) { File.read('tmp/test/imports/output_success_123.txt') }

        it 'should be exact as provided example' do
          perform_method
          expect(example_content).to eq(expected_content)
        end
      end
    end

    context 'when invalid' do
      shared_examples :should_not_be_failed do
        it 'should not fail script' do
          expect(perform_method).to eq(true)
        end
      end

      context 'missing timestamp' do
        let(:timestamp) { nil }
        it 'should fail script' do
          expect(perform_method).to eq(false)
        end
      end

      context 'missing one of the file' do
        let(:timestamp) { 'failed_missing_file' }
        it_behaves_like :should_not_be_failed
      end

      context 'missing data' do
        let(:timestamp) { 'failed_data' }

        it_behaves_like :should_not_be_failed
      end
    end
  end

  describe '#users_to_send' do
    subject(:perform_method) { service.send(:users_to_send) }
    before { service.run }

    context 'when valid' do
      let(:expected_users) { 7 }
      it 'should be sucessful' do
        expect(perform_method.size).to eq(expected_users)
      end
    end

    context 'when invalid' do
      shared_examples :should_not_send_emails do
        it 'should not prepare users for send' do
          expect(perform_method.size).to eq(0)
        end
      end

      context 'missing timestamp' do
        let(:timestamp) { nil }
        it_behaves_like :should_not_send_emails
      end

      context 'missing one of the file' do
        let(:timestamp) { 'failed_missing_file' }
        it_behaves_like :should_not_send_emails
      end

      context 'missing data' do
        let(:timestamp) { 'failed_data' }

        it_behaves_like :should_not_send_emails
      end
    end
  end
end
