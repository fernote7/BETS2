#' @title  Create a chart with a pre-defined BETS series
#' 
#' @description  Create a chart with a pre-defined BETS series
#' 
#' @param alias A \code{character}. The alias of the chart. A complete list of aliases for available charts is under the 'Details' section.
#' @param lang A \code{character}. The language. For now, only 'en' (english) is available.
#' @param out A \code{character}. The format of the output, that is, the image file. Can be either 'pdf' or 'png'. 'pdf' is a better choice if you need high resolution images. 
#' @param file A \code{character}. The whole path, including a custom name, for the output (an image file). The default value is 'graphs//parameter_alias' (the 'graphs' directory is under the BETS installation directory).
#' @param start A \code{vector}.
#' @param ylim  A \code{vector}.
#' @param xlim  A \code{vector}.
#' @param open  A \code{boolean}.
#'  
#' 
#' @details 
#' 
#' \tabular{lll}{
#'  VALUE \tab DESCRIPTION \tab CODE \cr
#'  \bold{'ipca_with_core'} \tab National consumer price index (IPCA) - in 12 months and  Broad national consumer price index - Core IPCA trimmed means smoothed \tab 13522 and 4466 \cr
#'  \bold{'ulc'} \tab Unit labor cost - ULC-US$ - June/1994=100 \tab 11777 \cr
#'  \bold{'eap'} \tab Economically active population \tab 10810 \cr
#'  \bold{'cdb'} \tab Time deposits (CDB/RDB-preset) - Daily return (percentage) \tab 14 \cr
#'  \bold{'indprod'} \tab Prodcution Indicators (2012=100) - General	\tab 21859 \cr
#'  \bold{'selic'} \tab Interest rate - Selic accumulated in the month in annual terms (basis 252) \tab 4189 \cr
#'  \bold{'unemp'} \tab Open unemployment rate - by metropolitan region - Brasil (weekly) \tab 10777\cr
#'  \bold{'vargdp'} \tab GDP - real percentage change in the year \tab 7326 
#'}
#' 
#' 
#' @return If the parameter \code{file} is not set by the user, the chart will be placed in the 'graphs' directory, under the BETS installation directory. 
#' 
#' @author Talitha Speranza \email{talitha.speranza@fgv.br}
#' 
#' @export


BETS.chart = function(alias, lang = "en", out = "png", file = NULL, start = c(2006,1), ylim = NULL, xlim = NULL, open = TRUE){
  
  if(lang == "en"){
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
  }
  else if(lang == "pt"){
    Sys.setlocale(category = "LC_ALL", locale = "Portuguese_Brazil.1252")
  }
  else {
    return(invisible(msg(.MSG_LANG_NOT_AVAILABLE)))
  }
  
  if(is.null(file)){
    dir.create("graphs", showWarnings = F)
    file = paste0("graphs","\\",alias)
  }
  
  if(out != "png"){
    if(out != "pdf"){
      return(invisible(msg(.MSG_OUT_NOT_AVAILABLE)))
    }
    
    if(!grepl("\\.pdf$", file)) {
      file <- paste(file,".pdf",sep="")
    }
  }
  else {
    if(!grepl("\\.png$", file)) {
      file <- paste(file,".png",sep="")
    }
  }
  
  dev.new()
  op <- par(no.readonly = TRUE)
  dev.off()
  par(op)
  
  if(grepl("\\.png", file)){
    png(file,width=728,height=478, pointsize = 15) 
  }
  else {
    pdf(file, width = 7, height = 4.5)
  }

  if(alias == "ipca_with_core"){
    draw.ipca(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "ulc"){
    draw.ulc(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "eap"){
    draw.eap(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "cdb"){
    
    if(identical(c(2006,1),start)){
      start = c(2006,1,1)
    }
    
    draw.cdb(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "indprod"){
    draw.indprod(start = start, xlim = xlim, ylim = ylim)
  }
  else if(alias == "selic"){
    draw.selic(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "unemp"){
    draw.unemp(start = start, ylim = ylim, xlim = xlim)
  }
  else if(alias == "vargdp"){
    draw.vargdp(start = start, ylim = ylim, xlim = xlim)
  }
  else {
    msg(paste("Plot was not created.",.MSG_PARAMETER_NOT_VALID))
  }
  
  dev.off()
  
  if(open){
    file.show(file)
  }
  
}