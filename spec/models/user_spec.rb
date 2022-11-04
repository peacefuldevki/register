# typed: ignore

require 'rails_helper'

describe User, type: :model do

  describe 'ActiveModel::Validations' do
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_confirmation_of(:password) }

    context 'with invalid password' do
      it { is_expected.to_not allow_value('a').for(:password) }
      it { is_expected.to_not allow_value('a1B').for(:password) }
      it { is_expected.to_not allow_value('12345678').for(:password) }
      it { is_expected.to_not allow_value('aaaaaaaa').for(:password) }
    end

    context 'with valid password' do
      it { is_expected.to allow_value('Password1!').for(:password) }
    end
  end
end
