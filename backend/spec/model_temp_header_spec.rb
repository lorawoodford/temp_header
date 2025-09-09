require 'spec_helper'

describe 'TempHeader model' do
  let(:temp_header) { TempHeader.all.first }

  it 'validates only one record can exist' do
    expect { TempHeader.new.save }.to raise_error(Sequel::ValidationFailed, /Cannot have more than one record in temp_header table./)
  end

  context 'when show_header is true' do
    let(:updated_header) do
      temp_header.show_header = true
      temp_header
    end

    it 'rejects an update without dates all dates exist' do
      expect { updated_header.save }.to raise_error(Sequel::ValidationFailed, /all_dates_required/)
    end

    it 'validates all dates exist' do
      updated_header.notice_date = Time.now
      updated_header.maintenance_start = Time.now + 1.day
      updated_header.maintenance_end = Time.now + 2.days

      expect { updated_header.save }.not_to raise_error
    end
  end

  context 'when show_header is false' do
    let(:updated_header) do
      temp_header.show_header = false
      temp_header
    end

    it 'does not validate all dates exist' do
      updated_header.maintenance_message = 'A message.'

      expect { updated_header.save }.not_to raise_error
    end
  end

  context 'when all dates provided' do
    let(:updated_header) do
      temp_header.notice_date = Time.now
      temp_header.maintenance_start = Time.now + 1.day
      temp_header.maintenance_end = Time.now + 2.days
      temp_header
    end

    it 'validates' do
      expect { updated_header.save }.not_to raise_error
    end

    it 'rejects bad dates' do
      updated_header.maintenance_start = 'Not a date'

      expect { updated_header.save }.to raise_error(Sequel::ValidationFailed, /not a valid date/)
    end

    it 'rejects an end date before a start' do
      updated_header.maintenance_end = Time.now - 2.days

      expect { updated_header.save }.to raise_error(Sequel::ValidationFailed, /must not be before begin/)
    end
  end
end
