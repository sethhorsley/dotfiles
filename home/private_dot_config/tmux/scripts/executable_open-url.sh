#!/bin/sh
# Open the URL on the clicked pane line, stripping wrapping ()/punctuation.
# Usage: open-url.sh <pane_id> <row>   (coords are safe; text is read here to dodge quoting)
# ponytail: opens first URL on the line, not column-aware; use mouse_x to disambiguate if lines carry 2+ links
extract() {
  grep -oE 'https?://[^ )>"]+' | head -1 | sed -E 's/[).,;:!?]+$//'
}

if [ "$1" = "--selftest" ]; then
  check() { got=$(printf '%s' "$2" | extract); [ "$got" = "$3" ] || { echo "FAIL [$2] -> [$got] want [$3]"; exit 1; }; }
  check _ "see (https://example.com/foo) here"      "https://example.com/foo"
  check _ "[docs](https://ex.com/a/b?x=1&y=2)."       "https://ex.com/a/b?x=1&y=2"
  check _ "it's not a url"                            ""
  echo ok; exit 0
fi

url=$(tmux capture-pane -p -t "$1" -S "$2" -E "$2" | extract)
[ -n "$url" ] && exec open "$url"
