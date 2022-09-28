#!/usr/bin/env -S nim e tools/routegen.nim

import std/[os, strutils, unicode]

const EXTENSIONS_TO_SERVE = @[".html", ".css", ".ttf", ".jpg"]
const DO_NOT_SERVE: seq[string] = @[]

proc quoted(x: string): string = result.addQuoted(x)

const initialCode = """## AUTOMATICALLY GENERATED!!! DO NOT EDIT!!! ##
import std/[strformat, strutils, mimetypes]

var m = newMimetypes()

proc returnAppropriateType(ctx: Context, page: string): Future[void] {.thread.} =
  ctx.response.body = getPage(page)
  var mimeType = m.getMimetype((page.split(".")[^1]))
  ctx.response.setHeader("content-type", fmt"{mimeType}; charset=UTF-8")
  result = newFuture[void]()

"""

var routes = initialCode
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
        " = complete(returnAppropriateType(ctx, \"" & ("html" / file) & "\"))\n"

        routes &= "app.get(" & quoted("/"&file) & ", " & routeName & ")\n\n"

writeFile("routes.nim", routes)
echo "Generated routes"