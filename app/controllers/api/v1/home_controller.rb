class Api::V1::HomeController < ShopifyApp::AuthenticatedController

  def index

    if !ShopifyAPI::ScriptTag.where(src:" #{ request.base_url}/index.js").present?
      ShopifyAPI::ScriptTag.create(:event => "onload" , :src =>" #{request.base_url}/index.js" )
    end

    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })

        
  end

end
