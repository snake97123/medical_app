function powder(){
 const list = document.getElementById('powder-list')
 const powder = document.getElementById('powder')
 list.style.visibility = "hidden";
 powder.addEventListener("click", () => {
    if (list.style.visibility === "hidden"){
         list.style.visibility = "visible"
    } else {
          list.style.visibility = "hidden"
    }

 });
}

window.addEventListener('load', powder)