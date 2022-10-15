## AUTOMATICALLY GENERATED!!! DO NOT EDIT!!! ##
import std/[strformat, mimetypes] # `strutils` is already imported in our code

var m = newMimetypes()
m.register("less", "text/css")

# Automatically get the correct mimetype
proc returnAppropriateType(ctx: Context, page: string): Future[void] {.thread.} =
  ctx.response.body = getPage(page)
  var mimeType = m.getMimetype((page.split(".")[^1]))
  ctx.response.setHeader("content-type", fmt"{mimeType}; charset=UTF-8")
  result = newFuture[void]()

proc serveIndexHtml(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/index.html"))
app.get("/index.html", serveIndexHtml)

proc serveResourcesFontsWizztaTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/wizzta.ttf"))
app.get("/resources/fonts/wizzta.ttf", serveResourcesFontsWizztaTtf)

proc serveResourcesFontsRudimentTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/rudiment.ttf"))
app.get("/resources/fonts/rudiment.ttf", serveResourcesFontsRudimentTtf)

proc serveResourcesFontsMagicschoolTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/magicschool.ttf"))
app.get("/resources/fonts/magicschool.ttf", serveResourcesFontsMagicschoolTtf)

proc serveResourcesImgsBackgroundJpg(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/imgs/background.jpg"))
app.get("/resources/imgs/background.jpg", serveResourcesImgsBackgroundJpg)

proc serveResourcesScriptsLessJs(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/scripts/less.js"))
app.get("/resources/scripts/less.js", serveResourcesScriptsLessJs)

proc serveLessStylesLess(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/less/styles.less"))
app.get("/less/styles.less", serveLessStylesLess)

