require 'nokogiri'
require 'open-uri'

=begin
 Nokogiri example.
 This lists the site navigation headers for the 
 UCSB CS website
=end

doc = Nokogiri::HTML(open("http://www.cs.ucsb.edu"))

# CSS selector example
nav = doc.css("div#site_nav")
nav.css('ul li').each do |h|
  p h.text
end

puts ""

# XPath selector example
nav = doc.xpath('id("site_nav")')
 nav.xpath('ul/li').each do |h|
  p h.text
end

