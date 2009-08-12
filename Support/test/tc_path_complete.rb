require 'test/unit'
require File.dirname(__FILE__) + '/../lib/path_complete'

class TestPathComplete < Test::Unit::TestCase
  # def setup
  # end
  # def teardown
  # end
  
  def test_initial_dir
    result = PathComplete::Path.new({ :input => 'include_once("/we");', :project_dir => '/Users/dbergey/repos/bitleap/branches/unstable', :file_path => '/Users/dbergey/repos/bitleap/branches/unstable/web/customer/include/config.php'}).run
    expected = 'include_once("/web");'
    assert_equal(expected, result)
  end

  def test_second_dir
    result = PathComplete::Path.new({ :input => 'include_once("/web/cus");', :project_dir => '/Users/dbergey/repos/bitleap/branches/unstable', :file_path => '/Users/dbergey/repos/bitleap/branches/unstable/web/customer/include/config.php'}).run
    expected = 'include_once("/web/customer");'
    assert_equal(expected, result)
  end
  
  def test_second_dir_with_base_path
    result = PathComplete::Path.new({ :input => 'include_once(BASE_PATH ."/web/cus");', :project_dir => '/Users/dbergey/repos/bitleap/branches/unstable', :file_path => '/Users/dbergey/repos/bitleap/branches/unstable/web/customer/include/config.php'}).run
    expected = 'include_once(BASE_PATH ."/web/customer");'
    assert_equal(expected, result)
  end
  
end