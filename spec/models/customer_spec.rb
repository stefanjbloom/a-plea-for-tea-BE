require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:firstname)  }
    it { should validate_presence_of(:lastname)  }
    it { should validate_presence_of(:email)  }
    it { should validate_presence_of(:address)  }
    it { should validate_length_of(:firstname).is_at_most(40) }
    it { should validate_length_of(:lastname).is_at_most(40) }
    it { should_not allow_value("test").for(:email) }
    it { should_not allow_value("test.com").for(:email) }
    it { should allow_value("test@example.com").for(:email) }
    it { should validate_uniqueness_of(:email)  }
  end

  describe 'associations' do
    it { should have_many(:subscriptions) }
    it { should have_many(:teas).through(:subscriptions) }
  end
end
