import std/[options, asyncdispatch, os, tables, sequtils, strutils]
import prologue

when defined(release):
  var htmlFiles: Table[string, string]  

proc getPage(loc: string): string =
  var filePath = join(loc.split(AltSep), $DirSep)
  when defined(release):
    if not htmlFiles.hasKey(filePath):
      htmlFiles[filePath] = readFile(filePath)
    else:
      return htmlFiles[filePath]
  else:
    return readFile(filePath)

proc serveIndex*(ctx: Context) {.async.} =
  resp getPage("html/index.html")

proc serveMainCss*(ctx: Context) {.async.} =
  resp getPage("html/css/index.css")

let app = newApp()

app.get("/", serveIndex)
app.get("/css/index.css", serveMainCss)

app.run()