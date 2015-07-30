# -*- encoding: utf-8 -*-

require "rexml/document"

def traverse(node, order)

  printf("%d,%s\n", order, node.name)
  order += 1

  if !node.has_elements? and node.has_text?
    printf("%d,%s\n", order, node.texts[0])
    order += 1
  else
    node.elements.each{|child|
      order = traverse(child, order)
    }
  end

  return order
end

file = File.new("sample.xml")
doc = REXML::Document.new file

root = doc.root

traverse(root, 1)
