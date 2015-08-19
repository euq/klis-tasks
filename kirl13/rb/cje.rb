# -*- coding: utf-8 -*-

module CJE
  def self.extract(file_name)
    words = Array.new
    flag = 0
    open(file_name, 'r') do |input|
      while line = input.gets
        line.chomp!
        title = line.match(/<NUM>(.*)<\/NUM>/)
        label = title[1] if title
        if line =~ /^<TEXT>/
          flag = 1
          next
        elsif line =~ /^<\/TEXT>/
          flag = 0
          next
        end
        if flag == 1
          item = line.split(" ")
          item.each do |word|
            word.downcase!
            word = "#{label} #{word.gsub(/\./,'').gsub(/,/,'')}"
            words.push(word)
          end
        end
      end
    end
    return words
  end
  def self.stopword(id_words)
    result = Array.new
    stops = ['a', 'the', 'and', 'in', 'is', 'of', 'am', 'for', 'to', 'on', 'by', 'as']
    id_words.each do |id_word|
      item = id_word.split(" ")
      result.push(item) if !stops.include?(item[1])
    end
    return result
  end
  def self.stemming(id_stopped_words)
    result = Array.new
    id_stopped_words.each do |id, stopped_word|
      stopped_word.sub!(/s$|ing$/, '')
      stopped_word.sub!(/ed$/, 'e')
      result.push([id,stopped_word])
    end
    return result
  end
  def self.tf(id_stemmed_words)
    result = Hash.new
    id_stemmed_words.each do |id, stemmed_word|
      result[id] = Hash.new if result[id] == nil
      if result[id][stemmed_word] == nil
        result[id][stemmed_word] = 1
      else
        result[id][stemmed_word] += 1
      end
    end
    return result
  end
  def self.idf(tf)
    n = tf.size
    df = Hash.new
    tf.each do |id, word_tf|
      word_tf.each do |word, word_tf_score|
        if df[word] == nil
          df[word] = 1
        else
          df[word] += 1
        end
      end
    end
    output = open('index.txt', 'w')
    tf.each do |id, word_tf|
      word_tf.each do |word, word_tf_score|
        idf = Math.log(n.to_f / df[word]) + 1
        weight = idf * word_tf_score
        output.print("#{id} #{word} #{idf} #{weight}\n")
      end
    end
    output.close
  end
  def self.retrieval(sm)
    id_index = Hash.new
    score = Hash.new
    open('index.txt', 'r') do |input|
      while line = input.gets
        item = line.split(' ')
        id_index[item[0]] = Hash.new if id_index[item[0]] == nil
        id_index[item[0]][item[1]] = item[3]
      end
    end
    sm.each do |id, word|
      id_index.each do |id, index|
        if index[word] != nil
          score[id] = 0 if score[id] == nil
          score[id] += index[word].to_f
        end
      end
    end
    hit = score.size
    puts "hit: #{hit}"
    score.sort{|a, b| score[a] <=> score[b]}.each do |id, weight|
      puts "#{id}: #{weight}"
    end
  end
end
