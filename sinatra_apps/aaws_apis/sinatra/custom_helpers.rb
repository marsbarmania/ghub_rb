require 'sinatra/base'
require "amazon"
require "amazon/aws"
require "amazon/aws/search"
require 'nokogiri'
require 'open-uri'


module Sinatra
  module CustomHelpers
    
    def yt_result_page(keyword)
      # https://developers.google.com/youtube/2.0/developers_guide_protocol_api_query_parameters
      api = 'http://gdata.youtube.com/feeds/api/videos'
      options ={'q'=>"#{URI.encode(keyword)}", 'max-result'=>10, 'v'=>2 }
      uri = URI( "#{api}?#{options.map{|k,v| "#{k}=#{v}"}.join('&')}" )
      nokog_xml = Nokogiri::XML(uri.read)
      
    end
    
    def result_page(keyword)
      begin
        request = Amazon::AWS::Search::Request.new
        item_search = Amazon::AWS::ItemSearch.new( "All", {"Keywords" => "#{keyword}"} )
        res_group = Amazon::AWS::ResponseGroup.new( 'Medium' )
      rescue => e
        e   
      else
        page = request.search( item_search, res_group)
      end      
    end
    
    def amazon_test
      request = Amazon::AWS::Search::Request.new
      item_search = Amazon::AWS::ItemSearch.new( "All", {"Keywords" => "sky"} )
      res_group = Amazon::AWS::ResponseGroup.new( 'Large' )
      page = request.search( item_search, res_group)     
       ### test ###
        puts "search count : #{page.item_search_response.items.total_results}"
        total = page.item_search_response.items.total_pages
        puts "total : #{total}"
        page.item_search_response.items.item.each do |i|
          puts "------------"
          #puts i
          #puts i.item_attributes
          puts "title = #{i.item_attributes.title}"
          puts "publisher = #{i.item_attributes.publisher}"
          puts "image = #{i.item_attributes.image}"
          author = i.item_attributes.author
          author.each { |k, v| puts "author = #{k}" } if not author.nil?
          puts "------------"
        end
        ### END TEST ###
    end
    
  end
  
  helpers CustomHelpers
  
end