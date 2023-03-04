require "mechanize"

module ApplicationHelper
  def render_flash_stream
    turbo_stream.update "flash", partial: "shared/flash"
  end
end
