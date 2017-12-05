# BibSonomy

[BibSonomy](https://www.bibsonomy.org/) plugin for
[Jekyll](http://jekyllrb.com/) which renders bibliographic metadata
using the [Citation Style Language](http://citationstyles.org/).

[![Gem Version](https://badge.fury.io/rb/bibsonomy-jekyll.svg)](http://badge.fury.io/rb/bibsonomy-jekyll)
[![Build Status](https://travis-ci.org/rjoberon/bibsonomy-jekyll.svg?branch=master)](https://travis-ci.org/rjoberon/bibsonomy-jekyll)

## Usage

(Read the Jekyll documentation on [installing a plugin](https://jekyllrb.com/docs/plugins/#installing-a-plugin).)

1. Add the following to your site's `Gemfile`:

```
gem 'bibsonomy-jekyll'
```

2. Add the following to your site's `_config.yml`:

```yml
gems:
  - bibsonomy-jekyll

bibsonomy:
  user: yourusername
  apikey: yourapikey
  # directory must exists; empty value disables document download
  document_directory: pdf
  # check https://github.com/citation-style-language/styles for styles
  style: acm-sig-proceedings
  # see http://api.altmetric.com/embeds.html for types and JavaScript
  # to enable them; empty value disables rendering
  altmetric_badge_type: 1
```

You can get your BibSonomy API key from
[the settings page](https://www.bibsonomy.org/settings?selTab=1#selTab1). **Do
not put your API key into a public repository.**

3. In any page or post, use the plugin as follows:

```markdown
{% bibsonomy user yourusername myown 3 %}
```

You should adapt the user name (`yourusername`)  and tag(s) (`myown`)
to your needs.

The plugin supports a variable number of parameters:
`GROUPING NAME TAG1 ... TAGN COUNT`
- `GROUPING` specifies whether posts for a user ("user") or group
  ("group") shall be rendered.
- `NAME` specifies the name of the user or group.
- `TAG1 ... TAGN` is a variable number of tags the posts should have.
- `COUNT` is the maximal number of posts that shall be rendered.

## Examples

For an example output, have a look at
[my publication list](https://amor.cms.hu-berlin.de/~jaeschkr/publications.html).
