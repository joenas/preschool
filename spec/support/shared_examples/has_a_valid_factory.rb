shared_examples 'has a valid factory' do
  When(:resource){build described_class.name.underscore}
  Then{expect(resource).to be_valid}
end
