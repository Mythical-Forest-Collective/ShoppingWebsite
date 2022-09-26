import std/[options, asyncdispatch, os, sharedtables, sequtils, strutils, macros]

import prologue
import prologue/middlewares/staticfile

const EXTENSIONS_TO_SERVE = @[".html", ".css"]
const DO_NOT_SERVE: seq[string] = @[]

# Refuse to compile if both is defined since it is illogical
when defined(staticPages) and defined(dynamicPages):
  {.error: "`staticPages` and `dynamicPages` can't be used at the same time!".}

# Allows us to toggle if we wanna use dynamic pages in release,
# default should be yes but keeping it here just in case
when (defined(release) and not defined(dynamicPages)) or defined(staticPages):
  var htmlFiles: SharedTable[string, string]  

# A single function to get the current page
proc getPage(loc: string): string =
  var filePath = join(loc.split(AltSep), $DirSep)
  # Allows for testing static pages in debug or disabling it in release
  when (defined(release) and not defined(dynamicPages)) or defined(staticPages):
    if not htmlFiles.hasKeyOrPut(filePath, readFile(filePath)):
      echo "Loaded `" & loc & "`"
    return htmlFiles.mget(filePath)
  else:
    return readFile(filePath)

let app = newApp()

app.get("/", (proc(ctx: Context) {.async.} = resp redirect("/index.html")))

static:
  var routes = ""
  for file in walkDirRec("html"):
    routes &= "proc " & file.replace($DirSep, "").replace(".", "") & "(ctx: Context) = resp getPage(\"" &
    file & "\")\n\n"

    routes &= "app.get"

  writeFile("routes.nim", routes)

app.run()