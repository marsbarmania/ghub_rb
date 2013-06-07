require 'net/http'
require 'xmlsimple'

module Youtube
  class Video
    HOST = "http://gdata.youtube.com/feeds/api/videos"
    ORDER_BY = ["relevance", "published", "viewCount", "rating"]
    FORMAT = 5                                              # Format of the videos
    YOUTUBE_VERSION = 2                                     # Youtube Client versie
    LANGAUGE = "nl"

    def initialize(dev_key = nil, width = nil, height = nil)
      raise "Error developer key required. Goto http://code.google.com/apis/youtube/dashboard/gwt/index.html" unless dev_key
      @dev_key  = dev_key
      @width    = width || 480
      @height   = height || 390
    end

    def find(uid = nil)
      return unless uid
      url = request_url({:uid => uid})
      xmlDoc = ::XmlSimple.xml_in(get_videos(url))
      video(xmlDoc) if xmlDoc
    end
    
    def search(query = nil, options = {})
      return [] unless query || query == ""
      options.merge!({:query => query.gsub(" ", "+")})
      options.merge!({:order_by => ORDER_BY.first})     unless options[:order_by]
      options.merge!({:max_results => 10})              unless options[:max_results]
      options.delete(:start_index)                      if options[:start_index] == "" || options[:start_index] == 0
      options.delete(:author)                           if !options[:author] || options[:author] == ""

      url = request_url(options)
      xmlDoc = ::XmlSimple.xml_in(get_videos(url))
      videos(xmlDoc) if xmlDoc
    end

    # private
    def request_url(params = {})
      url = "#{HOST}"
      url += "/#{params[:uid]}"                             if params[:uid]
      url += "?key=#{@dev_key}&v=#{YOUTUBE_VERSION}"
      url += "&q=#{params[:query]}"                         if params[:query]
      url += "&alt=#{params[:alt]}"                         if params[:alt]
      url += "&orderby=#{params[:order_by]}"                if params[:order_by]
      url += "&author=#{params[:author]}"                   if params[:author]
      url += "&callback=#{params[:callback]}"               if params[:callback]
      url += "&max-results=#{params[:max_results]}"         if params[:max_results]
      url += "&start-index=#{params[:start_index]}"         if params[:start_index]
      url += "&format=#{FORMAT}"
      # url += "&location=52.660559,4.802399&location-radius=500km"
      url += "&lr=nl&fs=1"
      url
    end

    def get_videos(url)
      Net::HTTP.get_response(URI.parse(url)).body
    end
    
    def videos(xmlDoc)
      return nil unless xmlDoc['entry']
      vids = xmlDoc['entry'].map do |entry|
        video(entry) if entry["content"]
      end
      vids.compact
    end

    def video(entry)
      {
        :id           => entry["group"].first["videoid"].first,
        :title        => entry["group"].first["title"].first["content"],
        :description  => entry["group"].first["description"].first["content"],
        :thumbnail    => entry["group"].first["thumbnail"].first["url"],
        :source       => entry["content"]["src"],
        :author       => entry["author"].first["name"].first,
        :player       => video_template(entry["group"].first["videoid"].first)
      }
    end

    def video_template(id)
      "<iframe width='#{@width}' height='#{@height}' src='http://www.youtube.com/embed/#{id}?wmode=transparent' frameborder='0' allowfullscreen></iframe>"
    end
  end
end