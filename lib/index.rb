class Index
  attr_reader :text

  def initialize
    @text = {}
  end

  def update(filename, content)
    @text[filename] = content.split("\n").map(&:split)
  end

  def query(term)
    result = []
    text.each do |filename, lines|
      lines.each_with_index do |line, line_index|
        line.each_with_index do |word, word_index|
          result << "#{filename}:#{line_index}:#{word_index}" if word == term
        end
      end
    end
    result.sort
  end
end
