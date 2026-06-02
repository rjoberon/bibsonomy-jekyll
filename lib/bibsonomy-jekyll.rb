# coding: utf-8
require 'jekyll'
require 'time'
require 'bibsonomy/csl'


#
# Jekyll Tag to render posts from BibSonomy.
#
# Usage: {% bibsonomy [:OPTKEY OPTVAL] GROUPING NAME TAG1 TAG2 ... TAGN COUNT %}
#   where
#     GROUPING is either "user" or "group" and specifies the type of NAME
#     NAME is the name of the group or user
#     TAG1 ... TAGN are tags
#     COUNT is an integer, the number of posts to return
#
# Changes:
# 2026-06-02 (rja)
# - added generic setting (and override) of csl configuration options
# 2018-10-08 (rja)
# - added liquid expansion
# 2017-05-31 (rja)
# - added support for groups and multiple tags
#

module Jekyll

  class BibSonomyPostList < Liquid::Tag

    # these bibsonomy/csl configuration options are supported
    CONFIG_OPTS = ['pdf_dir', 'altmetric_badge_type', 'style', 'year_headings', 'css_class']

    def initialize(tag_name, text, tokens)
      super
      @input = text
    end


    def render(context)
      rendered_input = Liquid::Template.parse(@input).render(context)
      parts = rendered_input.split(/\s+/)

      # parameters starting with : can override csl configuration options
      opts = get_opts(parts)
      # use (remaining/actual) parameters
      grouping = parts.shift
      name = parts.shift
      # the last element is the number of posts
      count = Integer(parts.pop)
      # everything else are the tags
      tags = parts

      # configure CSL
      config = context.registers[:site].config['bibsonomy']
      csl = BibSonomy::CSL.new(config['user'], config['apikey'])
      configure(csl, config, opts)

      html = csl.render(grouping, name, tags, count)

      # set date to now
      context.registers[:page]["date"] = Time.new

      return html
    end


    def get_opts(parts)
      opts = {}
      # parameters starting with : can override configuration options
      # only at the beginning → the first string without : stops loop
      while parts[0].start_with?(':')
        opts[parts.shift[1..]] = parts.shift
      end
      return opts
    end


    #
    # set values in csl from config, possibly overriden by opts
    #
    def configure(csl, config, opts)
      # work on a copy of the configuration and override using opts
      config = config.clone.merge(opts)
      # set values from config in CSL
      (CONFIG_OPTS & config.keys()).each do |key, value|
        # TODO: access attribute by string → ok or hack?
        csl.instance_variable_set('@' + key, value)
      end

      # HACK: convert the only (so far) boolean variable to boolean
      if csl.year_headings.is_a?(String)
         csl.year_headings = csl.year_headings.downcase == "true"
      end

    end
  end

end

Liquid::Template.register_tag('bibsonomy', Jekyll::BibSonomyPostList)
