module Jekyll
  class ExampleTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      args = text.strip.split
      @file = args[0]
    end

    def render(context)
      @context = context
      "<pre><code>#{excerpt}</code></pre>"
    end

    def excerpt
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
  end
end

Liquid::Template.register_tag('example', Jekyll::ExampleTag)
