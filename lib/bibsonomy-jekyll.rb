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
    def initialize(tag_name, text, tokens)
      super
      parts = text.split(/\s+/)
      @grouping = parts.shift
      @name = parts.shift
      # the last element is the number of posts
      @count = Integer(parts.pop)
      # everything else are the tags
      @tags = parts
    end
    
    def render(context)
      site = context.registers[:site]

      # user name and API key for BibSonomy
      user_name = site.config['bibsonomy_user']
      api_key = site.config['bibsonomy_apikey']
      csl = BibSonomy::CSL.new(user_name, api_key)

      # target directory for PDF documents
      pdf_dir = site.config['bibsonomy_document_directory']
      csl.pdf_dir = pdf_dir
      
      # CSL style for rendering
      style = site.config['bibsonomy_style']
      csl.style = style

      html = csl.render(@grouping, @name, @tags, @count)

      # set date to now
      context.registers[:page]["date"] = Time.new
      
      return html
    end
  end

end

Liquid::Template.register_tag('bibsonomy', Jekyll::BibSonomyPostList)
