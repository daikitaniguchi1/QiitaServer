class API < Grape::API
  format :json

  helpers do

    def error_handling!(message, code)
      p message
      Rails.logger.error("code:#{code}: #{message}")
      error!({error: message}, code)
    end

  end

  resource :items do
    get do
      begin
        Item.all
      rescue => e
        error_handling!(e.message, 400)
      end
    end

    post do
      begin
        Item.set_items_from_api
      rescue => e
        error_handling!(e.message, 400)
      end
    end

  end
end
