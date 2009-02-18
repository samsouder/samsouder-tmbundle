require 'test/unit'
require File.dirname(__FILE__) + '/../lib/reformat_css'

class TestReformatCSS < Test::Unit::TestCase
  # def setup
  # end
  # def teardown
  # end
  
  def test_oneliner_with_brackets
    result = Reformat::CSS.new({ :input => '{ background-position: left 0; }', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '{ background-position: left 0; }'
    assert_equal(expected, result)
  end
  
  def test_oneliner_no_brackets
    result = Reformat::CSS.new({ :input => ' background-position: left 0; ', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = 'background-position: left 0;'
    assert_equal(expected, result)
  end
  
  def test_twoliner_with_brackets
    result = Reformat::CSS.new({ :input => '{ color: red; background-position: left 0; }', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '{
  background-position: left 0;
  color: red;
}'
    assert_equal(expected, result)
  end
  
  def test_twoliner_no_brackets
    result = Reformat::CSS.new({ :input => ' color: red; background-position: left 0; ', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '  background-position: left 0;
  color: red;'
    assert_equal(expected, result)
  end
  
  def test_multiline_with_brackets
    result = Reformat::CSS.new({ :input => '{
      position: absolute;
      top: 0;
      color: #999;
      right: 0;
      -webkit-border-top-left-radius: 5px;
      -moz-border-radius-topright: 5px;
    }', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '{
  -moz-border-radius-topright: 5px;
  -webkit-border-top-left-radius: 5px;
  color: #999;
  position: absolute;
  right: 0;
  top: 0;
}'
    assert_equal(expected, result)
  end
  
  def test_multiline_no_brackets
    result = Reformat::CSS.new({ :input => '
      position: absolute;
      top: 0;
      color: #999;
      right: 0;
      -webkit-border-top-left-radius: 5px;
      -moz-border-radius-topright: 5px;
    ', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '  -moz-border-radius-topright: 5px;
  -webkit-border-top-left-radius: 5px;
  color: #999;
  position: absolute;
  right: 0;
  top: 0;'
    assert_equal(expected, result)
  end
  
  def test_soft_tabs
    result = Reformat::CSS.new({ :input => 'position: absolute; top: 0;', :soft_tabs => 'YES', :tab_size => 4}).run
    expected = '    position: absolute;
    top: 0;'
    assert_equal(expected, result)
  end
  
  def test_tabs
    result = Reformat::CSS.new({ :input => 'position: absolute; top: 0;', :soft_tabs => 'NO', :tab_size => 4}).run
    expected = '	position: absolute;
	top: 0;'
    assert_equal(expected, result)
  end
  
  def test_multiline_with_comments
    result = Reformat::CSS.new({ :input => '
      top: 0; /* this is a comment */
      position: absolute;
    ', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '  position: absolute;
  top: 0; /* this is a comment */'
    assert_equal(expected, result)
  end
  
  def test_oneline_twostatements_with_comments
    result = Reformat::CSS.new({ :input => '{top: 0; /* this is a comment */ position: absolute;}', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '{
  position: absolute;
  top: 0; /* this is a comment */
}'
    assert_equal(expected, result)
  end
  
  def test_oneline_manystatements_with_comments
    result = Reformat::CSS.new({ :input => '{top: 0; /* this is a comment */ position: absolute; bottom: 4px; right: 0}', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '{
  bottom: 4px;
  position: absolute;
  right: 0;
  top: 0; /* this is a comment */
}'
    assert_equal(expected, result)
  end
  
  def test_always_end_semicolon
    result = Reformat::CSS.new({ :input => 'top: 0
  position: absolute', :soft_tabs => 'YES', :tab_size => 2}).run
    expected = '  position: absolute;
  top: 0;'
    assert_equal(expected, result)
  end
end