require 'builder'
include Rails.application.routes.url_helpers

class Sitemap
  STATIC_URLS = ['/about',
                 '/terms',
                 '/contact']

  class << self
    def generate
      @bad_pages = []  
      @pages_to_visit = []
      @url = "http://www.caliburnentertainment.co.uk"
      
      @pages_to_visit  = STATIC_URLS
      @pages_to_visit += Product.all.collect{ |a| product_path(a) }
      @pages_to_visit += Category.all.collect{ |c| shop_path(:category => c.dasherized_name, :ancestors => c.ancestors_for_route) }

      generate_sitemap
    end
    
    # Notify popular search engines of the updated sitemap.xml
    def update_search_engines
      sitemap_uri = "http://www.caliburnentertainment.co.uk/sitemap.xml"
      escaped_sitemap_uri = CGI.escape(sitemap_uri)
      Rails.logger.info "Notifying Google"
      res = Net::HTTP.get_response('www.google.com', '/webmasters/tools/ping?sitemap=' + escaped_sitemap_uri)
      Rails.logger.info res.class
      Rails.logger.info "Notifying Yahoo"
      res = Net::HTTP.get_response('search.yahooapis.com', '/SiteExplorerService/V1/updateNotification?appid=SitemapWriter&url=' + escaped_sitemap_uri)
      Rails.logger.info res.class
      Rails.logger.info "Notifying Bing"
      res = Net::HTTP.get_response('www.bing.com', '/webmaster/ping.aspx?siteMap=' + escaped_sitemap_uri)
      Rails.logger.info res.class
      Rails.logger.info "Notifying Ask"
      res = Net::HTTP.get_response('submissions.ask.com', '/ping?sitemap=' + escaped_sitemap_uri)
      Rails.logger.info res.class
    end

    private
    
    def generate_sitemap
      xml_str = ""
      xml = Builder::XmlMarkup.new(:target => xml_str, :indent => 2)

      xml.instruct!
      xml.urlset(:xmlns=>'http://www.sitemaps.org/schemas/sitemap/0.9') {
        @pages_to_visit.each do |url|
          unless @url == url
            xml.url {
              xml.loc(@url + url)
              xml.lastmod(Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00"))
             }
          end
        end
      }
      
      xml
    end
  end
end