require 'rubygems'
require 'sinatra'
require 'haml'
require 'rss'


set :haml, {:format => :html5 }


FEEDS = [
  {
    :slug => 'front',
    :url => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/front_page/rss.xml',
    :title => 'Front page',
  },
  {
    :slug => 'scotland',
    :url => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/scotland/rss.xml',
    :title => 'Scotland',
  },
  {
    :slug => 'technology',
    :url => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/technology/rss.xml',
    :title => 'Technology',
  }
]


before do
  headers 'Content-Type' => 'text/html; charset=utf-8'
end


get '/' do
  redirect '/front' # Lazy
end


get '/:feed' do
  @feedName = params[:feed]

  FEEDS.each do |feed|
    if feed[:slug] == @feedName
      @theFeed = feed
      break
    end
  end

  rss = RSS::Parser.parse(@theFeed[:url])
  @feeds = FEEDS
  @items = rss.items[0, 5]

  haml :index
end
