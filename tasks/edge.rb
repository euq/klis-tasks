# -*- encoding: utf-8 -*-

require "rexml/document"

def traverse(node, order, pre)

  order += 1
  puts "#{pre}|#{order}" if pre != 0

  if !node.has_elements? and node.has_text?
    pre = order
    order += 1
    puts "#{pre}|#{order}"
  else
    pre = order
    node.elements.each{|child|
      order = traverse(child, order, pre)
    }
  end

  return order
end

file = File.new("sample.xml")
doc = REXML::Document.new file
root = doc.root

traverse(root, 0, 0)
