# BibSonomy

[BibSonomy](https://www.bibsonomy.org/) plugin for [Jekyll](http://jekyllrb.com/).

[![Gem Version](https://badge.fury.io/rb/bibsonomy-jekyll.svg)](http://badge.fury.io/rb/bibsonomy-jekyll)
[![Build Status](https://travis-ci.org/rjoberon/bibsonomy-jekyll.svg?branch=master)](https://travis-ci.org/rjoberon/bibsonomy-jekyll)

## Usage

1. Add the following to your site's `Gemfile`:

```
gem 'bibsonomy-jekyll'
```

2. Add the following to your site's `_config.yml`:

```yml
gems:
  - bibsonomy-jekyll

bibsonomy-jekyll:
  user: "yourusername"
  apikey: "yourapikey"
```

You can get your BibSonomy API key from [the settings page](https://www.bibsonomy.org/settings?selTab=1#selTab1).

3. In any page or post, use the plugin as follows:

```markdown
{% bibsonomy user yourusername myown 3 %}
```

You should adapt the user name (`yourusername`)  and tag(s) (`myown`)
to your needs.


### Notes

- Ensure that the directory `pdf` exists, which is configured in
  variable `document_directory`. Configuring an empty directory
  disables downloading of documents.

- The plugin supports a variable number of parameters: GROUPING NAME
  TAG1 ... TAGN COUNT
  - GROUPING specifies whether posts for a user ("user") or group
    ("group") shall be rendered.
  - NAME specifies the name of the user or group.
  - TAG1 ... TAGN is a variable number of tags the posts should have.
  - COUNT is the maximal number of posts that shall be rendered.
