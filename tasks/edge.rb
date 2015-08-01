# -*- encoding: utf-8 -*-

require "rexml/document"

def traverse(node, order, pre)

  order += 1
  p "#{pre}|#{order}"
  printf("%d,%s\n", order, node.name)

  if !node.has_elements? and node.has_text?
    pre = order
    order += 1
    p "#{pre}|#{order}"
    printf("%d,%s\n", order, node.texts[0])
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

p traverse(root, 0, 0)
