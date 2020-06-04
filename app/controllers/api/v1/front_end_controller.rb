class Api::V1::FrontEndController < ApplicationController
  def index
    debugger;
    # @shop = Shop.find_by_shopify_domain(params[:shop])
    # @stored_products = StoredProduct.belongs_to_shop(@shop)
    # render json: @stored_products
    # @product = ShopifyAPI::Product.find(params[:prodID])
    # shopify_session = ShopifyAPI::Session.new(domain: params[:shop], api_version: "2020-04", token: nil);
    # permission_url = shopify_session.create_permission_url(scope, "https://my_redirect_uri.com", { state: "My Nonce" })
    # @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })

    # shop = params[:shop]
    # session = ShopifyAPI::Session.new(domain: shop, token: Shop.first.shopify_token, api_version: "2020-04");
    # ShopifyAPI::Base.activate_session(session)

    # ShopifyAPI::Session.setup(api_key: ShopifyApp.configuration.api_key, secret: ShopifyApp.configuration.secret);

    # shop = params[:shop]
    # # We need to instantiate the session object before using it
    # shopify_session = ShopifyAPI::Session.new(domain: shop, api_version: "2020-04", token: nil)
   
    # # Then, create a permission URL with the session
    # permission_url = shopify_session.create_permission_url(scope, "https://my_redirect_uri.com", { state: "My Nonce" })

    # @shop = Shop.find_by_shopify_domain(params[:shop])
    # debugger;
    # render json: "It worked kind of"
  end
end
