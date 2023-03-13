class UpdateLinkDataJob < ApplicationJob
  queue_as :default

  def perform(link)
    url = link.url
    link.update(
      title: link_title(url),
      image_url: link_image_url(url),
      category: link_category(url)
    )
  end

  private

  def link_category(url)
    return "Videos" if URI(url).host.include?("youtube") || URI(url).host.include?("vimeo")
    "Articles"
  end

  def link_title(url)
    Mechanize.new.get(url).title
  end

  def link_image_url(url)
    Mechanize.new.get(url).at('meta[property="og:image"]')&.[]('content')
  end
end