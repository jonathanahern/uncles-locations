# frozen_string_literal: true
require 'shopify_api'
require "graphql/client"
require "graphql/client/http"

class AppProxyController < ApplicationController
  
  include ShopifyApp::AppProxyVerification

  def index
    ShopifyAPI::Session.setup(api_key: ENV['api_key'], secret: ENV['api_secret'])
    uncToken = Shop.first.shopify_token;
    session = ShopifyAPI::Session.new(domain: params[:shop] , token: uncToken, api_version: "2020-04")
    ShopifyAPI::Base.activate_session(session)
    ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
    # ShopifyAPI::GraphQL.schema_location = '../../db/shopify_graphql_schemas/2020-04.json'
 
    client = ShopifyAPI::GraphQL.client

    query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      query getVariantByID($id: ID!) {
        productVariant(id: $id) {
          id
          title
          inventoryItem {
            id
          }
        }
      }
    GRAPHQL

    variables = {
      "id": `gid://shopify/ProductVariant/#{params[varID]}`
    }

    result = ShopifyAPI::GraphQL.client.query(query,variables)
    
    
    render json: {"Shop": result.data}

  end

end

# https://{shop}.myshopify.com/admin/api/2020-04/products/{product_id}/variants/{variant_id}.json
    # prodParams = {product_id: params[:prodID], variant_id:params[:varID] }

    
    # inventoryID = ShopifyAPI::Variant.find(params[:varID], :params => {:product_id => params[:prodID]}).id
 
    # inventory_item_ids: [inventoryID].join(","), 35355507261573
    # paramsNew = {inventory_item_ids: [35355507261573].join(","), location_ids: [45213089925,45111574661,43767038085].join(",")}
    # newNums = ShopifyAPI::InventoryLevel.find(:all, params: paramsNew)

    # paramsLoc = {inventory_item_ids: inventoryID.to_s, location_ids: "45213089925,45111574661,43767038085" }
    # inventory = ShopifyAPI::InventoryLevel.find(params[:varID], params: paramsLoc)
    # @inventoryID = ShopifyAPI::Product.find(params: prodParams);
    # params2 = { inventory_item_ids: inventoryID.to_s }
    
    # inventory_levels = ShopifyAPI::InventoryLevel.find(:all, :params => {:inventory_item_ids => inventoryID.to_s})
# => array_of_inventory_levels

#     {id: 45213089925, name: "Bellevue Crossroads Mall", address1: "15600 NE 8th St", address2: "Suite K10", city: "Bellevue", …}
# 1: {id: 43564302469, name: "Downtown Spokane", address1: "404 W Main", address2: "", city: "Spokane", …}
# 2: {id: 45111574661, name: "Redmond Towncenter", address1: "7325 166th Avenue Northeast", address2: "f150", city: "Redmond", …}
# 3: {id: 43767038085, name: "Spokane Valley Mall",