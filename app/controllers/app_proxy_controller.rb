# frozen_string_literal: true
require 'shopify_api'
require "graphql/client"
require "graphql/client/http"

class AppProxyController < ApplicationController
  
  include ShopifyApp::AppProxyVerification

  def index

    locations = {
      "79065841797" => "Bellevue Crossroads Mall",
      "78964031621" =>"Redmond Towncenter",
      "77614874757" =>"Spokane Valley Mall"
      # "77411942533" =>"Downtown Spokane"
    }

    locationsInventory = []
  
    ShopifyAPI::Session.setup(api_key: ShopifyApp.configuration.api_key, secret: ShopifyApp.configuration.secret)
    uncToken = Shop.first.shopify_token;
    session = ShopifyAPI::Session.new(domain: params[:shop] , token: uncToken, api_version: "2020-04")
    ShopifyAPI::Base.activate_session(session)
    ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
    # ShopifyAPI::GraphQL.schema_location = '../../db/shopify_graphql_schemas/2020-04.json'
 
    client = ShopifyAPI::GraphQL.client

    query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      query ($id: ID!) {
        productVariant(id: $id) {
          id
          title
          inventoryItem {
            id
          }
        }
      }
    GRAPHQL

    varID = params[:varID]
    result = ShopifyAPI::GraphQL.client.query( query, variables: { id: "gid://shopify/ProductVariant/#{varID}" })
    invID = result.data.product_variant.inventory_item.id.split('/').pop
      
    queryLoc = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      query($id: ID!) {
      inventoryItem(id: $id) {
        id
        inventoryLevels (first:4) {
          edges {
            node {
              id
              available
            }
          }
        }
      }
      }
    GRAPHQL

    resultLoc = ShopifyAPI::GraphQL.client.query( queryLoc, variables: { id: "gid://shopify/InventoryItem/#{invID}" })
    locArr = resultLoc.data.inventory_item.inventory_levels.edges

    locArr.each do |ele|
      locNum = ele.node.id.split("?")[0].split("/").pop;
      num = ele.node.available;
      if (locations.has_key?(locNum))
        locName = locations[locNum];
        locationsInventory << [locName,num]
      end
    end

    render json: {"Inventory": locationsInventory }

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

#    {id: 45213089925, name: "Bellevue Crossroads Mall", address1: "15600 NE 8th St", address2: "Suite K10", city: "Bellevue", …}
# 1: {id: 43564302469, name: "Downtown Spokane", address1: "404 W Main", address2: "", city: "Spokane", …}
# 2: {id: 45111574661, name: "Redmond Towncenter", address1: "7325 166th Avenue Northeast", address2: "f150", city: "Redmond", …}
# 3: {id: 43767038085, name: "Spokane Valley Mall",

# 77411942533: 2 Downtown Spokane
# 77614874757: 1 Spokane Valley Mall
# 78964031621: 4 Redmond
# 79065841797: 1 Bellevue Crossroads Mall