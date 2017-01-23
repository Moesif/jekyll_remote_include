require 'net/http'
require "jekyll"

module Jekyll
  # Remotely fetch a markdown file.
  class RemoteIncludeTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super

      text.strip!
      check_protocol(text)
      uri = URI(text)

      check_extension(uri.path)

      res = Net::HTTP.get_response(uri)
      fail 'resource unavailable' unless res.is_a?(Net::HTTPSuccess)

      @content = res.body.force_encoding("UTF-8")
    end

    def render(_context)
      # remove Title from readme (i.e. # Web SDK)
      @content = @content.gsub(/(^|\n)#\s.*/, '')

      # remove Doc Links from readme
      @content = @content.gsub(/.*check out moesif.*www\.moesif\.com.*to learn more.*/i, '')
      @content
    end

    private

    def check_protocol(text)
      error_message = "remote_include: invalid URI #{text}"
      fail error_message unless text =~ URI.regexp(%w(http https ftp ftps))
    end

    def check_extension(path)
      mdexts = %w(.markdown .mkdown .mkdn .mkd .md)
      error_message = "remote_include: URI extension not in #{mdexts}"
      fail error_message unless mdexts.include?(File.extname(path))
    end
  end
end

Liquid::Template.register_tag('remote_include', Jekyll::RemoteIncludeTag)

