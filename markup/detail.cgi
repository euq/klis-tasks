#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'cgi'
require 'xml/xslt'

cgi = CGI.new
print cgi.header("text/html; charset=UTF-8")
begin
  xslt = XML::XSLT.new()
  xslt.xml = "data.xml"
  xslt.xsl = "view_detail.xsl"
  xslt.parameters = {"param_tag" => cgi['tag']}
  out = xslt.serve()
  print out
rescue
  puts 'error'
end
