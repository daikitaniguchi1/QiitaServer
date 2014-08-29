require 'spec_helper'

describe 'item_api' do

  subject do
    get "api/items"
    response.status
  end
  it { expect(subject).to eq(200) }

end
