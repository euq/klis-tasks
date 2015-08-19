# -*- encoding: utf-8 -*-
# @author = himkt
# @create = 2015/08/03
# ex5

require "rexml/document"

def traverse(node, order)

  puts "#{order}|#{node.name}|#{node.node_type}"
  order += 1

  if !node.has_elements? and node.has_text?
    puts "#{order}|#{node.texts[0]}|#{node.texts[0].node_type}"
    order += 1
  else
    node.elements.each{|child|
      order = traverse(child, order)
    }
  end

  return order
end

file = File.new("./jbisc100.xml")
doc = REXML::Document.new file

root = doc.root

traverse(root, 1) 
