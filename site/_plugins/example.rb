module Jekyll
  class ExampleTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      args = text.strip.split
      @file = args[0]
    end

    def render(context)
      "<pre><code>#{excerpt}</code></pre>"
    end

    def excerpt
      first_delim = contents.lines.drop_while { |l| !l.include?('[excerpt]') }
      after_delim = first_delim[1..-1]
      between_delim = after_delim.take_while { |l| !l.include?('[excerpt]') }
      between_delim.join('')
    end

    def contents
      File.read(@file)
    end
  end
end

Liquid::Template.register_tag('example', Jekyll::ExampleTag)
