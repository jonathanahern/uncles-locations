# frozen_string_literal: true
require 'shopify_api'
require "graphql/client"
require "graphql/client/http"

class AppProxyController < ApplicationController
  
  include ShopifyApp::AppProxyVerification

  def index


    # locations = {
    #   "79065841797" => "Bellevue Crossroads Mall&https://www.unclesgames.com/pages/crossroads-mall",
    #   "78964031621" =>"Redmond Towncenter&https://www.unclesgames.com/pages/redmond-town-center",
    #   "77614874757" =>"Spokane Valley Mall&https://www.unclesgames.com/pages/spokane-valley-uncles",
    #   "77411942533" =>"Downtown Spokane&https://www.unclesgames.com/pages/downtown-spokane-uncles"
    # }

    # locationsInventory = []
  
    # ShopifyAPI::Session.setup(api_key: ShopifyApp.configuration.api_key, secret: ShopifyApp.configuration.secret)
    # uncToken = Shop.first.shopify_token;
    # session = ShopifyAPI::Session.new(domain: params[:shop] , token: uncToken, api_version: "2020-04")
    # ShopifyAPI::Base.activate_session(session)
    # ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
 
    # client = ShopifyAPI::GraphQL.client

    # query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
    #   query ($id: ID!) {
    #     productVariant(id: $id) {
    #       id
    #       title
    #       inventoryItem {
    #         id
    #       }
    #     }
    #   }
    # GRAPHQL

    # varID = params[:varID]
    # result = ShopifyAPI::GraphQL.client.query( query, variables: { id: "gid://shopify/ProductVariant/#{varID}" })
    # invID = result.data.product_variant.inventory_item.id.split('/').pop
      
    # queryLoc = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
    #   query($id: ID!) {
    #   inventoryItem(id: $id) {
    #     id
    #     inventoryLevels (first:4) {
    #       edges {
    #         node {
    #           id
    #           available
    #         }
    #       }
    #     }
    #   }
    #   }
    # GRAPHQL

    # resultLoc = ShopifyAPI::GraphQL.client.query( queryLoc, variables: { id: "gid://shopify/InventoryItem/#{invID}" })
    # locArr = resultLoc.data.inventory_item.inventory_levels.edges

    # locArr.each do |ele|
    #   locNum = ele.node.id.split("?")[0].split("/").pop;
    #   num = ele.node.available;
    #   num = "0" if num.to_i < 0;
    #   if (locations.has_key?(locNum))
    #     locName = locations[locNum];
    #     locationsInventory << [locName,num]
    #   end
    # end

    # render json: {"Inventory": locationsInventory }
    render json: {"Inventory": "coming back to you" }

  end

end