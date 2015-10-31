module ApplicationHelper
  # Gravatar support for user avatars
  def avatar_url(user)
    user.profile_image
    #gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    #"https://secure.gravatar.com/avatar/#{gravatar_id}.png?d=identicon"
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  # Used for markdown support in contents
  def markdown(text)
    renderer = HTMLwithPygments.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true,
      :space_after_headers => true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def sanitize_code(html)
    doc = Nokogiri::HTML(html)
    doc.search("//code").each do |pre|
      pre.children.each do |child|
        child.replace child.text
      end
    end
    doc.to_s
  end

  # Might be unnecessary, but helps limit content lengths
  def condenseString(text)
    condensed = strip_tags( markdown text )
    if(condensed.length > 300)
      condensed = condensed[0...299] + "..."
    end
    sanitize condensed
  end
end
