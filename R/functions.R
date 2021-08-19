# =======================================================================
# Project-specific functions.
# =======================================================================

`%notin%`=function(x,y) !(x %in% y)

# ggsave two for one
ggsave_pngpdf <-  function(plot_var, fileslug_var, formats="png", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in"){

  if(!is.na(formats)){
    ggsave(dir_plots(paste({{ fileslug_var }}, ".png", sep="")), plot={{ plot_var }}, device="png", type="cairo", scale={{ scale_var }}, width={{ width_var }}, height={{ height_var }}, units={{ units_var }}, dpi={{ dpi_var }}, limitsize=TRUE)
    ggsave(dir_plots(paste({{ fileslug_var }}, "_lores.png", sep="")), plot={{ plot_var }}, device="png", type="cairo", scale={{ scale_var }}, width={{ width_var }}, height={{ height_var }}, units={{ units_var }}, dpi=96, limitsize=TRUE)
    ggsave(dir_plots(paste({{ fileslug_var }}, ".pdf", sep="")), plot={{ plot_var }}, device=cairo_pdf, scale={{ scale_var }}, width={{ width_var }}, height={{ height_var }}, units={{ units_var }}, dpi={{ dpi_var }}, limitsize=TRUE)
  }
  else{
    if(formats == "png"){
      ggsave(dir_plots(paste({{ fileslug_var }}, ".png", sep="")), plot={{ plot_var }}, device="png", type="cairo", scale={{ scale_var }}, width={{ width_var }}, height={{ height_var }}, units={{ units_var }}, dpi={{ dpi_var }}, limitsize=TRUE)
      # ggsave(dir_plots(paste({{ fileslug_var }}, "_lores.png", sep = "")), plot = {{ plot_var }}, device = "png", type = "cairo", scale = {{ scale_var }}, width = {{ width_var }}, height = {{ height_var }}, units = {{ units_var }}, dpi = 96, limitsize = TRUE)
    }

    if(formats == "pdf"){
      ggsave(dir_plots(paste({{ fileslug_var }}, ".pdf", sep="")), plot={{ plot_var }}, device=cairo_pdf, scale={{ scale_var }}, width={{ width_var }}, height={{ height_var }}, units={{ units_var }}, dpi={{ dpi_var }}, limitsize=TRUE)
    }
  }

  # ggsave_instagram({{ plot_var }}, {{ fileslug_var }})

}



calculate_pct_chg <- function(x){

  pct_chg_tmp <- (x - lag(x)) / abs(lag(x)) * 100

  return(pct_chg_tmp)

}

mape <- function(actual,pred){

  mape <- mean(abs((actual - pred)/actual))*100

  return (mape)

}
