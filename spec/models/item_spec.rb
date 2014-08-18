require 'spec_helper'

describe Item do

  describe 'set_items_from_api' do
    let(:item){Item.new}
    let(:per_page){Settings.items[:per_page]}
    let(:page){Settings.items[:page]}

    before do
      expect(Item).to receive(:get) {mock_response}
      item.set_items_from_api
    end
    it { expect(Item.count()).to eq(1) }
    it { expect(Item.all.pluck(:qiita_id).first).to eq(1) }
    it { expect(Item.all.pluck(:data).first['url']).to eq('http://qiita.com') }
  end

  def mock_response
    [{"id"=>1, "stock_count"=>100, "url"=>"http://qiita.com"}]
  end

end