# frozen_string_literal: true

require 'spec_helper.rb'
require 'rails_helper.rb'

describe TempHeaderHelper do
  let(:bad_date) { 'not a date' }
  let(:long_date) { '2025-08-27 10:00:00 UTC' }
  let(:short_date) { '2025-08-27' }

  describe '#short_date' do
    context 'when a short date is given' do
      it 'returns properly formatted date' do
        expect(TempHeaderHelper::short_date(short_date)).to eq('8-27-2025')
      end
    end

    context 'when a long date is given' do
      it 'returns properly formatted date' do
        expect(TempHeaderHelper::short_date(long_date)).to eq('8-27-2025')
      end
    end

    context 'when a bad date is given' do
      it 'returns an empty string' do
        expect(TempHeaderHelper::short_date(bad_date)).to eq('')
      end
    end
  end

  describe '#long_date' do
    context 'when a short date is given' do
      it 'returns an empty string' do
        expect(TempHeaderHelper::long_date(short_date)).to eq('')
      end
    end

    context 'when a long date is given' do
      it 'returns properly formatted date' do
        expect(TempHeaderHelper::long_date(long_date)).to eq('Wednesday, August 27')
      end
    end

    context 'when a bad date is given' do
      it 'returns an empty string' do
        expect(TempHeaderHelper::long_date(bad_date)).to eq('')
      end
    end
  end

  describe '#long_time' do
    context 'when a short date is given' do
      it 'returns an empty string' do
        expect(TempHeaderHelper::long_time(short_date)).to eq('')
      end
    end

    context 'when a long date is given' do
      it 'returns properly formatted date' do
        expect(TempHeaderHelper::long_time(long_date)).to eq(' 6:00AM EDT')
      end
    end

    context 'when a bad date is given' do
      it 'returns an empty string' do
        expect(TempHeaderHelper::long_time(bad_date)).to eq('')
      end
    end
  end
end
