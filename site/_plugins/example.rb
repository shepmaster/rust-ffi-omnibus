module Jekyll
  class ExampleTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      args = text.strip.split
      @file = args[0]
    end

    def render(context)
      @context = context
      "<pre><code class='#{filetype}'>#{excerpt}</code></pre>"
    end

    def excerpt
      CGI.escape_html(raw_excerpt)
    end

    def raw_excerpt
      return contents unless has_excerpt?

      first_delim = contents.lines.drop_while { |l| !l.include?('[excerpt]') }
      after_delim = first_delim[1..-1]
      between_delim = after_delim.take_while { |l| !l.include?('[excerpt]') }
      between_delim.join('')
    end

    def has_excerpt?
      contents.include? '[excerpt]'
    end

    def contents
      @contents ||= File.read(filename)
    end

    def filename
      File.join(filebase, @file)
    end

    def filebase
      @context.registers[:page].fetch('examples', './')
    end

    def filetype
      TYPE_HINTS[File.extname(@file)]
    end

    TYPE_HINTS = {
      ".c" => "c",
      ".cs" => "csharp",
      ".hs" => "haskell",
      ".js" => "javascript",
      ".py" => "python",
      ".rb" => "ruby",
      ".rs" => "rust",
    }
  end
end

Liquid::Template.register_tag('example', Jekyll::ExampleTag)
