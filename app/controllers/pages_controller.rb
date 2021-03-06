class PagesController < ApplicationController

  def show
    @page = Cms::Page.find_by_slug(params[:id])
    if @page

      # meta data
      @meta[:title] = @page.title
      @meta[:description] = @page.meta_desc

      # cms data
      unless @page.body.blank?
        markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML,
          autolink: true,
          tables: true,
          space_after_headers: true,
          disable_indented_code_blocks: true
        )
        @text = markdown.render(@page.body).html_safe
      end

    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end