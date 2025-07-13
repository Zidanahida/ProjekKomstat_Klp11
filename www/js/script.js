
// for (let i = 0; i < legend_button.length; i++) {
//         isclick[i] = false; // Inisialisasi array isclick
    
//         legend_button[i].addEventListener("click", function() {
//         var area_name = this.id.replace('box-', '');
        
//         isclick[i] = !isclick[i]; // Toggle status klik
        
//         if(isclick[i]) {
//                 this.style.backgroundColor = "#f0f0f0 !important";
//             } else {
    //                     this.style.backgroundColor = "#fff !important";
    //                 }
    
    //             });
    //         }
    
var legend_button = document.getElementsByClassName("legend-box");
let selected_areas = ["default"];
let isclick = [];
    
$(document).on('click', '.legend-box', function() {
    var area_name = $(this).attr('id').replace('box-', '');
    if(isclick[area_name]===undefined){
        isclick[area_name]=false;
    }
    isclick[area_name] = !isclick[area_name];
    if(isclick[area_name]){
        $(this).css('background-color','#f0f0f0');
        selected_areas.push(area_name);
    }
    else{
        $(this).css('background-color','#fff');
         selected_areas = selected_areas.filter(a => a !== area_name);
    }
    Shiny.setInputValue('selected_area', selected_areas, {priority: 'event'});
}); 

$(document).ready(function() {
        function matchHeight() {
          var textHeight = $('#about-text-box').outerHeight();
          $('#about-img').css('height', textHeight + 'px');
        }

        matchHeight();

        $(window).on('resize', function() {
          matchHeight();
        });
      });
                                                  