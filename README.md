Kindle Clipping Extractor
=========================
[![CI](https://github.com/kchien/KindleClippingExtractor/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/kchien/KindleClippingExtractor/actions/workflows/ci.yml)
[![CodeFactor](https://www.codefactor.io/repository/github/kchien/KindleClippingExtractor/badge)](https://www.codefactor.io/repository/github/kchien/KindleClippingExtractor)

A quick script (in alpha status) that will read the Amazon Kindle clippings
file and create files that you can import into [Anki](http://ankisrs.net/).

## Usage
1. bundle install
2.    bundle exec kce path_to_kindle_clippings_file

(or, once installed as a gem: `kce path_to_kindle_clippings_file`)

### Options:
    -o, --output-dir DIR   Directory to write Anki import files to (default: current directory)
    -f, --from DATE        Only include highlights added on or after DATE
    -t, --to DATE          Only include highlights added on or before DATE (inclusive)

Both date flags are optional and may be used on their own to leave the range
open at that end. `--from` starts at the beginning of the day given and `--to`
runs through the end of it, so a single day is `--from D --to D`.

### Example:
    bundle exec kce ~/MyClippings.txt
    bundle exec kce -o ~/anki_import ~/MyClippings.txt
    bundle exec kce --from 2013-05-01 --to 2013-05-31 ~/MyClippings.txt


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/kchien/kindleclippingextractor/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

