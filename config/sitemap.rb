# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.notelimites.com"


SitemapGenerator::Sitemap.public_path = 'tmp/'

# The remote host where your sitemaps will be hosted
SitemapGenerator::Sitemap.sitemaps_host = "https://s3.amazonaws.com/imagenes.notelimites/"

SitemapGenerator::Sitemap.sitemaps_path = ''

# Instance of `SitemapGenerator::WaveAdapter`
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #



  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add all events:
     Event.all.where('start_date > ?' , Date.today ).each do |event|
      add event_path(event),
          :lastmod => Time.now,
         # :@context => 'http://schema.org',
         # :@type => 'Event',
         # :name => event.name,
         # :startDate => event.fecha,
         # :url => event.urloficial,
         # :location => {
         # :@type => 'Place',
         # :name => event.venue.name,
         # :address => event.venue.lugar},
          :changefreq => 'daily',
          :priority => 0.9
     end




  # Add all venues:
    Venue.all.each  do |venue|
      add venue_path(venue),
          :lastmod => Time.now,
          :changefreq => 'weekly'
    end

  SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
end
