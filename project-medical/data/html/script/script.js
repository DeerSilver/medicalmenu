// first variables
let menutoggle = document.querySelector('.toggle')
let menu = document.querySelector('.menu')
let IsMenuVisible = false


// the rest of the variables

let reviveb = document.querySelector('.revive')
let checkb = document.querySelector('.checkinjuries')
let patientb = document.querySelector('.patient')
let hospb = document.querySelector('.hospitalize')


// display event listener whatever


$(function () {
    function display(bool) {
        if (bool) {
            $(".menu").show();
        } else {
            $(".menu").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })


    menutoggle.onclick = function(){
        menu.classList.toggle('active')
        menutoggle.classList.toggle('active')
        if (IsMenuVisible === true) {
            display(false)
            IsMenuVisible = false
            $.post("https://project-medical/display", JSON.stringify({
                data: IsMenuVisible
            }))
        } else{
            display(true)
            IsMenuVisible = true
            $.post("https://project-medical/display", JSON.stringify({
                data: IsMenuVisible
            }))
        }
    }

    reviveb.onclick = function(){
        $.post("https://project-medical/revive", JSON.stringify({
            data: false
        }))
    }
    checkb.onclick = function(){
        $.post("https://project-medical/drag", JSON.stringify({
            data: false
        }))
    }
    patientb.onclick = function(){
        $.post("https://project-medical/logged", JSON.stringify({
            data: false
        }))
    }
    hospb.onclick = function(){
        $.post("https://project-medical/drag", JSON.stringify({
            data: false
        }))
    }
})