proc serveIndexHtml(ctx: Context) {.async.} = resp getPage("html/index.html")
app.get("/index.html", serveIndexHtml)

proc serveCssStylesCss(ctx: Context) {.async.} = resp getPage("html/css/styles.css")
app.get("/css/styles.css", serveCssStylesCss)

proc serveResourcesFontsWizztaTtf(ctx: Context) {.async.} = resp getPage("html/resources/fonts/wizzta.ttf")
app.get("/resources/fonts/wizzta.ttf", serveResourcesFontsWizztaTtf)

proc serveResourcesFontsRudimentTtf(ctx: Context) {.async.} = resp getPage("html/resources/fonts/rudiment.ttf")
app.get("/resources/fonts/rudiment.ttf", serveResourcesFontsRudimentTtf)

proc serveResourcesFontsMagicschoolTtf(ctx: Context) {.async.} = resp getPage("html/resources/fonts/magicschool.ttf")
app.get("/resources/fonts/magicschool.ttf", serveResourcesFontsMagicschoolTtf)

