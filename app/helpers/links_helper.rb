module LinksHelper
  def link_title(url)
    Mechanize.new.get(url).title
  end

  def link_image_url(url)
    Mechanize.new.get(url).at('meta[property="og:image"]')&.[]('content')
  end

  def link_host(url)
    URI(url).host
  end
end