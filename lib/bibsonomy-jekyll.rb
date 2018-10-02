# coding: utf-8
require 'jekyll'
require 'time'
require 'bibsonomy/csl'


#
# Jekyll Tag to render posts from BibSonomy.
#
# Usage: {% bibsonomy GROUPING NAME TAG1 TAG2 ... TAGN COUNT %}
#   where
#     GROUPING is either "user" or "group" and specifies the type of NAME
#     NAME is the name of the group or user
#     TAG1 ... TAGN are tags
#     COUNT is an integer, the number of posts to return
#
# Changes:
# 2017-05-31 (rja)
# - added support for groups and multiple tags
#

module Jekyll

  class BibSonomyPostList < Liquid::Tag

    def lookup(parameter, context)
      # Emulate Liquid-tag rendering
      match = parameter.match(/{{\s*([a-zA-Z_]\w*)\s*}}/)
      if match
        variable = match[1]
        return context[variable]
      else
        return parameter
      end
    end

    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      parts = @params.split(/\s+/)
      grouping = lookup(parts.shift, context)
      name = lookup(parts.shift, context)
      # the last element is the number of posts
      count = Integer(lookup(parts.pop, context))
      # everything else are the tags
      tags = parts.map { |p| lookup(p, context) }

      site = context.registers[:site]

      # user name and API key for BibSonomy
      bib_config = site.config['bibsonomy']
      csl = BibSonomy::CSL.new(bib_config['user'], bib_config['apikey'])

      # target directory for PDF documents
      csl.pdf_dir = bib_config['document_directory']

      # Altmetric badge type
      csl.altmetric_badge_type = bib_config['altmetric_badge_type']

      # CSL style for rendering
      csl.style = bib_config['style']

      html = csl.render(grouping, name, tags, count)

      # set date to now
      context.registers[:page]["date"] = Time.new

      return html
    end
  end

end

Liquid::Template.register_tag('bibsonomy', Jekyll::BibSonomyPostList)
