require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:customer_id)  }
    it { should validate_presence_of(:tea_id)  }
    it { should validate_presence_of(:title)  }
    it { should validate_presence_of(:price)  }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
    it { should validate_numericality_of(:customer_id).only_integer }
    it { should validate_numericality_of(:tea_id).only_integer }
    it { should validate_numericality_of(:price) }
    it { should validate_inclusion_of(:status).in_array(%w(active canceled)).with_message("Invalid Status") }
  end

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end
end