# frozen_string_literal: true
class AppProxyController < ApplicationController
  include ShopifyApp::AppProxyVerification

  def index
    ShopifyAPI::Session.setup(api_key: ENV['api_key'], secret: ENV['api_secret'])
    # ShopifyAPI::Base.api_version = '2020-04'
    # # We need to instantiate the session object before using it
    # shopify_session = ShopifyAPI::Session.new(domain: params[:shop], api_version: '2020-04', token: nil)
    # # Then, create a permission URL with the session
    # permission_url = shopify_session.create_permission_url("read_products, read_script_tags, write_script_tags, read_inventory", "https://my_redirect_uri.com", { state: "My Nonce" })
    session = ShopifyAPI::Session.new(domain: params[:shop] , token: params[:signature], api_version: "2020-04")
    ShopifyAPI::Base.activate_session(session)
    @product = ShopifyAPI::Product.find(params[:prodID])
    # fetch(`https://#{params[:shop]}/admin/api/2020-04/locations.json`, {
    #      method: "GET",
    #  })
    #      .then(res => res.json())
    #      .then(resp => {
    #          render json: {resp};
    #      })
    
    render json: {"Product": @product}

  end

end
