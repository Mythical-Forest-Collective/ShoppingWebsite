#!/usr/bin/env -S nim e tools/routegen.nim

import std/[os, strutils, unicode]

const EXTENSIONS_TO_SERVE = @[".html", ".css", ".ttf"]
const DO_NOT_SERVE: seq[string] = @[]

proc quoted(x: string): string = result.addQuoted(x)

var routes = ""
for file in walkDirRec("html", relative=true):
  for ext in EXTENSIONS_TO_SERVE:
    if file.endsWith(ext):
      if not (file in DO_NOT_SERVE):
        var routeName = "serve" & file.multiReplace(
          ($DirSep, " "),
          (".", " "),
          ("-", " ")
        ).title().replace(" ", "")

        routes &= "proc " & routeName & "(ctx: Context) {.async.}" &
        " = resp getPage(\"" & ("html" / file) & "\")\n"

        routes &= "app.get(" & quoted("/"&file) & ", " & routeName & ")\n\n"

writeFile("routes.nim", routes)
echo "Generated routes"