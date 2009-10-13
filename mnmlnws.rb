require 'rubygems'
require 'sinatra'
require 'haml'
require 'rss'


set :haml, {:format => :html5 }


FEEDS = {
  'front' => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/front_page/rss.xml',
  'scotland' => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/scotland/rss.xml',
  'technology' => 'http://newsrss.bbc.co.uk/rss/newsonline_uk_edition/technology/rss.xml',
}


before do
  headers 'Content-Type' => 'text/html; charset=utf-8'
end


get '/' do
  redirect '/front' # Lazy
end


get '/:feed' do
  feed = FEEDS[params[:feed]]
  rss = RSS::Parser.parse(feed)
  @items = rss.items[0, 5]
  haml :index
end
