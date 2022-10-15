import std/[asyncdispatch, os, strutils]

import prologue

# Refuse to compile if both is defined since it is illogical
when defined(staticPages) and defined(dynamicPages):
  {.error: "`staticPages` and `dynamicPages` can't be used at the same time!".}

# Allows us to toggle if we wanna use dynamic pages in release,
# default should be yes but keeping it here just in case
when (defined(release) and not defined(dynamicPages)) or defined(staticPages):
  import std/sharedtables

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

# Create the prologue app
let app = newApp()

# Just preference
app.get("/", (proc(ctx: Context) {.async.} = resp redirect("/index.html")))

# We generate the routes at compile time, while this still means we have to recompile for new resources,
# it still is less tedious, also, we could probably replace this with a macro
include ./routes

# Run the prologue app
app.run()