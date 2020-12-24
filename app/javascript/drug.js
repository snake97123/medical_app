function drug(){
 const powder_list = document.getElementById('powder-list')
 const powder = document.getElementById('powder')
 const tablet_list = document.getElementById('tablet-list')
 const tablet = document.getElementById('tablet')
 tablet_list.style.visibility = "hidden";
 powder_list.style.visibility = "hidden";
 powder.addEventListener("click", () => {
    if (powder_list.style.visibility === "hidden"){
         powder_list.style.visibility = "visible"
    } else {
          powder_list.style.visibility = "hidden"
    }

 });
 tablet.addEventListener("click", () => {
      if (tablet_list.style.visibility === "hidden"){
           tablet_list.style.visibility = "visible"
      } else {
            tablet_list.style.visibility = "hidden"
      }
  
   });
}

window.addEventListener('load', drug)