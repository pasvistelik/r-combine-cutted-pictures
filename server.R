
str("start initializing...")
listfiles <- system("cmd.exe", input = "dir /a /b /s D:\\500_files_proj\\data", intern = TRUE)
library(jpeg)
datalist <- lapply(7:length(listfiles)-2, function(index){readJPEG(listfiles[index])})
datalist1 <- lapply(datalist, function(d) d[,,1])
getImageMatrix <- function(v=1:500) t(do.call(cbind, datalist1[v]));
#myshowimgs <- function(v=1:500) image(do.call(cbind, datalist1[v]))

library(GA)

imagecompare <- function(i1, i2){ i1<- datalist[[i1]]; i2<- datalist[[i2]]; sum((i1[,dim(i1)[2],1] - i2[,1,1])^2) }
m0 <- outer(1:500,1:500, FUN = Vectorize(imagecompare))
optim.FUN<-function(v){mm<-m0[v,v]; -(sum(mm[tr.upp]*mw)+1000/sum(mm[tr.down]))}

library(parallel)
library(doRNG)

tr.upp<-col(m0)>row(m0)
tr.down<-col(m0)<row(m0)
mw<-(1/((col(m0)-row(m0))^2))[tr.upp]

#str("run 1 iteration...")

#g<-gaisl(type = "permutation", fitness = optim.FUN, min = 1, max = 500, popSize = 5000, maxiter = 1, parallel = TRUE, migrationInterval = 5, numIslands = 4, suggestions = tryCatch(g@solution, error = function(e) NULL))

str("initialized...")

#myshowimgs();
outfile <- tempfile('temp.png')
png(outfile, width=600, height=500)

#canHandleEvents <- TRUE;

shinyServer(function(input, output) {

  observeEvent(input$my_button, {
   str("click handled");
   #g<-gaisl(type = "permutation", fitness = optim.FUN, min = 1, max = 500, popSize = 5000, maxiter = 1, parallel = TRUE, migrationInterval = 5, numIslands = 4, suggestions = tryCatch(g@solution, error = function(e) NULL))
    
  })
  
  output$full_image <- renderImage({
    
    return(list(
      src = outfile, #"Rplot.png",
      contentType = "image/png",
      alt = "Face",
      #width = 500,
      height = 500
    ))
  }, deleteFile = FALSE)
  
})