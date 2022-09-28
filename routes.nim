## AUTOMATICALLY GENERATED!!! DO NOT EDIT!!! ##
import std/[strformat, strutils, mimetypes]

var m = newMimetypes()

proc returnAppropriateType(ctx: Context, page: string): Future[void] {.thread.} =
  ctx.response.body = getPage(page)
  var mimeType = m.getMimetype((page.split(".")[^1]))
  ctx.response.setHeader("content-type", fmt"{mimeType}; charset=UTF-8")
  result = newFuture[void]()

proc serveIndexHtml(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/index.html"))
app.get("/index.html", serveIndexHtml)

proc serveCssStylesCss(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/css/styles.css"))
app.get("/css/styles.css", serveCssStylesCss)

proc serveResourcesFontsWizztaTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/wizzta.ttf"))
app.get("/resources/fonts/wizzta.ttf", serveResourcesFontsWizztaTtf)

proc serveResourcesFontsRudimentTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/rudiment.ttf"))
app.get("/resources/fonts/rudiment.ttf", serveResourcesFontsRudimentTtf)

proc serveResourcesFontsMagicschoolTtf(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/fonts/magicschool.ttf"))
app.get("/resources/fonts/magicschool.ttf", serveResourcesFontsMagicschoolTtf)

proc serveResourcesImgsBackground_1920x1080Jpg(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/imgs/background_1920x1080.jpg"))
app.get("/resources/imgs/background_1920x1080.jpg", serveResourcesImgsBackground_1920x1080Jpg)

proc serveResourcesImgsBackground_3840x2160Jpg(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/imgs/background_3840x2160.jpg"))
app.get("/resources/imgs/background_3840x2160.jpg", serveResourcesImgsBackground_3840x2160Jpg)

proc serveResourcesImgsBackgroundJpg(ctx: Context) {.async.} = complete(returnAppropriateType(ctx, "html/resources/imgs/background.jpg"))
app.get("/resources/imgs/background.jpg", serveResourcesImgsBackgroundJpg)

