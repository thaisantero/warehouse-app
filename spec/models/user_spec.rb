require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe nome e email' do
      u = User.new(name: 'Thais Antero', email: 'thais@gmail.com')

      result = u.description

      expect(result).to eq('Thais Antero - thais@gmail.com')
    end
  end
end
