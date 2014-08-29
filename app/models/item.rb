class Item
  include Mongoid::Document
  field :qiita_id, type: Integer
  field :data, type: Hash

  include HTTParty
  base_uri 'https://qiita.com/api/v1'

  class << self
    def set_items_from_api
      1.step(Settings.items[:page], 1) do |index|
        save_items_from(api_response(index))
      end
    end

    def api_response(page)
      self.get('/items.json',
                     { query: {per_page:Settings.items[:per_page], page: page} }
      )
    end

    def save_items_from(parsed_json)
      parsed_json.each do |item|
        next if is_exist?(item['id']) || under_threshold?(item['stock_count'])
        Item.create(qiita_id: item['id'], data: item)
        p "qiita_id #{item['id']} is saved!"
        p item['url']
      end
    end

    def is_exist?(qiita_id)
      Item.where(qiita_id: qiita_id).length > 0
    end

    def under_threshold?(stock)
      stock < Settings.items[:threshold]
    end
  end

end