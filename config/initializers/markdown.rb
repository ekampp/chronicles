class String
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def markdown
    text = self.to_s
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def sanitize(type = :relaxed)
    type = case type
    when :restricted
      Sanitize::Config::RESTRICTED
    when :basic
      Sanitize::Config::BASIC
    else
      Sanitize::Config::RELAXED
    end
    Sanitize.clean(self.to_s, type)
  end
end
