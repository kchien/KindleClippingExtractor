Kindle Clipping Extractor
=========================
[![CI](https://github.com/kchien/KindleClippingExtractor/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/kchien/KindleClippingExtractor/actions/workflows/ci.yml)
[![Code Climate](https://codeclimate.com/github/kchien/KindleClippingExtractor.png)](https://codeclimate.com/github/kchien/KindleClippingExtractor)

A quick script (in alpha status) that will read the Amazon Kindle clippings
file and create files that you can import into [Anki](http://ankisrs.net/).

## Usage
1. bundle install
2.    bundle exec kce path_to_kindle_clippings_file

(or, once installed as a gem: `kce path_to_kindle_clippings_file`)

### Example:
    bundle exec kce ~/MyClippings.txt
    bundle exec kce -o ~/anki_import ~/MyClippings.txt


## TODO
1. Add command line option to specify date range


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/kchien/kindleclippingextractor/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

