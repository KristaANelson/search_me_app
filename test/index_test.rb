require 'minitest'
require 'minitest/autorun'
require_relative '../lib/index'

class IndexTest < Minitest::Test
  def setup
    @text = "love to one only roses\ni could not have done that says my\nremains inexorable eventually the memory yields"
    @text2 = "roses are red\nviolets are blue\nI'm a student at Turing\nand so are you!"
    @index = Index.new
  end

  def test_it_indexes_text
    @index.update("testfile", @text)
    assert_equal 3, @index.text["testfile"].count
  end

  def test_it_can_query
    @index.update("testfile", @text)
    result = @index.query("love")
    assert_equal ["testfile:0:0"], result
  end

  def test_it_can_query_with_multiple_files
    @index.update("testfile", @text)
    @index.update("testfile2", @text2)
    result = @index.query("student")
    assert_equal ["testfile2:2:2"], result
  end

  def test_it_can_query_multiple_matches
    @index.update("btestfile2", @text2)
    @index.update("atestfile", @text)
    result = @index.query("roses")
    assert_equal ["atestfile:0:4", "btestfile2:0:0"], result
  end
end


# Expected response: JSON array of occurrences in the previously indexed text.
#  Format: "filename:line-number:word-number". EG: file1.txt:125:5.
