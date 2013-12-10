class MockController
  attr_writer :action_name

  def _routes
    self
  end

  def action_name
    defined?(@action_name) ? @action_name : 'edit'
  end

  def url_for(*args)
    'http://example.com'
  end

  def url_options
    {}
  end

  def hash_for_article_path(*); end

  def hash_for_articles_path(*); end
end
