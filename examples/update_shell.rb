#!/usr/bin/env ruby

require 'mechanize'

class UpdateShell 
  URI = 'https://accounts.engr.ucsb.edu/maintain/login'

  def initialize
    @agent = Mechanize.new
    @page = @agent.get(URI)
  end

  def login(username, password)
    form = @page.forms.first
    form['data[Maintain][username]'] = username
    form['data[Maintain][password]'] = password
    @page = @agent.submit(form)
    self
  end

  def update(shell)
    page = @agent.click(@page.link_with(:text => /Change Login Shell/))
    form = page.forms.first
    value = nil
    form.field_with(:name => 'data[Maintain][shell]').options.each do |o|
      if o.text == shell
        value = o
      end
    end
    form.field_with(:name => 'data[Maintain][shell]').value = value
    @agent.submit(form)
    self
  end
end

UpdateShell.new.login('username', 'password').update('/bin/bash')
