# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
bundle install                                  # install deps (Ruby 4.0.6, see .ruby-version)
bundle exec rspec                                # run all specs
bundle exec rspec spec/kindle_extractor/make_cards_spec.rb        # one file
bundle exec rspec spec/kindle_extractor/make_cards_spec.rb:20     # one example by line
bundle exec rake                                 # default task == spec
bundle exec kce ~/MyClippings.txt                # run the CLI
bundle exec kce -o ~/anki_import ~/MyClippings.txt
```

CI (`.github/workflows/ci.yml`) runs `bundle exec rspec` on pushes/PRs to `main`.

## Architecture

A small gem (`kindle_extractor`) that turns an Amazon Kindle `MyClippings.txt` file into
tab-separated Anki import files — one file per book title.

The pipeline is three collaborating objects, wired together in `exe/kce` and injected via
constructors (this is what makes the specs dependency-free — every collaborator is a double):

1. `ParsesKindleClippingFile` (`lib/kindle_extractor/parses_kindle_clipping_file.rb`) —
   wraps the external `kindleclippings` gem. `#lines` returns only `highlights`;
   notes and bookmarks in the clippings file are silently dropped.
2. `FiltersByDateRange` (`lib/kindle_extractor/filters_by_date_range.rb`) — optional
   `--from`/`--to` narrowing. Either end may be nil (open range); with both nil it is a
   pass-through and never touches the timestamps.
3. `MakeCards` (`lib/kindle_extractor/make_cards.rb`) — the orchestrator. Pulls
   `file_parser.lines`, runs it through the date filter, and hands each surviving
   highlight to `file_writer.write_out`. Holds no knowledge of files or formats.
4. `WritesAnkiImportFile` (`lib/kindle_extractor/writes_anki_import_file.rb`) — formats
   one highlight as `content<TAB>title|author|location` and appends it to
   `<output_dir>/<book_title>.txt`.

Each object carries a single responsibility and is named after it (verb-phrase class names);
keep new steps in that shape rather than adding methods to the existing classes.

The highlight objects flowing through the pipeline are `KindleClippings::Clipping` instances
(`book_title`, `author`, `type`, `location`, `added_on`, `content`, `page`) — that gem's API
defines the contract the doubles in the specs mimic.

### Things that bite

- `WritesAnkiImportFile` opens files in append mode (`'a'`) and defaults its output directory
  to `ENV['PWD']` (not `Dir.pwd`). Re-running over the same clippings file duplicates cards,
  and specs must `FakeFS::FileSystem.add(File.expand_path(ENV['PWD']))` for writes to work.
- Specs use `fakefs/spec_helpers`; any real path a test touches has to be registered with
  `FakeFS::FileSystem.add` first.
- `spec_helper.rb` sets `disable_monkey_patching!`, so use `RSpec.describe`, never bare
  `describe`. Order is random and seeded.
- Date filtering is ours, not the `kindleclippings` gem's: `ClippingResult#highlights`
  returns a plain `Array`, so the gem's `by_date` cannot be chained after it, and `by_date`
  requires *both* ends of the range anyway.
- A `Clipping` whose timestamp matched none of the gem's three date formats has
  `added_on == nil`; such highlights are dropped whenever a range is active.
- The gemspec globs `lib/**/*.rb` and `exe/*` at build time — a new file is picked up
  automatically, but only if it lives there.
- `diff-lcs` stays on 1.x: `rspec-expectations` constrains it to `< 2.0`, so `bundle outdated`
  will always list it as behind. Nothing to do there.
