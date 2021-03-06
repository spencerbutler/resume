#!/bin/sh
# Spencer Butler <github@crooked.app>
# Convert SpencerButler.md to SpencerButler.{html,pdf,txt}

resume="${resume:-"SpencerButler"}"

pandoc -s "${resume}".md -t html5 -o "${resume}".html
pandoc -s "${resume}".md -t latex  -o "${resume}".pdf

sed -e 's/^#*[[:space:]]//g' "${resume}".md > "${resume}".txt

cp "${resume}".md README.md
