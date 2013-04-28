#!/usr/bin/env ruby

require 'mechanize'
require 'mail'

class CLSearch 
  URI = 'http://santabarbara.craigslist.org'

  def initialize
    @agent = Mechanize.new
    @page = @agent.get(URI)
  end

  def search(for_what)
    form = @page.forms.first
    form['query'] = for_what
    @page = @agent.submit(form)
    #p @page
    results = @page.search(".//p[@class='srch row']").to_html
    self.send_results(results)
    self
  end

  def send_results(results)
    mail = Mail.new do
      to 'you@somewhere'
      from 'you@somewhere'
      content_type 'text/html'
      charset 'UTF-8'
      subject 'search results'
      body results
    end
    mail.deliver
  end
end

puts CLSearch.new.search('kayak')
