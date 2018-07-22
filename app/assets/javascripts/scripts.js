var clicks = 0;

document.addEventListener("turbolinks:load", function () {
    clicks = 0;
});

function edit_step(id) {
    document.getElementById("edit_step_" + id).style.display = "block";
    document.getElementById("step_" + id).style.display = "none";
    document.getElementById("step_buttons_" + id).style.display = "none";
}

function cancel_step_edit(id) {
    document.getElementById("edit_step_" + id).style.display = "none";
    document.getElementById("step_" + id).style.display = "inline";
    document.getElementById("step_buttons_" + id).style.display = "inline";
}

function edit_ingredient(id) {
    document.getElementById("edit_ingredient_" + id).style.display = "block";
    document.getElementById("ingredient_" + id).style.display = "none";
    document.getElementById("ingredient_buttons_" + id).style.display = "none";
}

function cancel_ingredient_edit(id) {
    document.getElementById("edit_ingredient_" + id).style.display = "none";
    document.getElementById("ingredient_" + id).style.display = "inline";
    document.getElementById("ingredient_buttons_" + id).style.display = "inline";
}

function decide(x) {
    if (clicks == 0) {
        document.getElementById("mobile_nav").style.visibility = "visible";
        document.getElementById("mobile_nav").style.opacity = "1";
        document.getElementById("mobile_nav").style.zIndex = "5";
        document.getElementById("bar1").style.border = "none";
        document.getElementById("bar3").style.border = "none";
        x.classList.toggle("change");
        clicks = 1;
    }

    else if (clicks == 1) {
        document.getElementById("mobile_nav").style.visibility = "hidden";
        document.getElementById("mobile_nav").style.opacity = "0";
        document.getElementById("mobile_nav").style.zIndex = "0";
        document.getElementById("bar1").style.border = "1px solid black";
        document.getElementById("bar3").style.border = "1px solid black";
        x.classList.toggle("change");
        clicks = 0;
    }
}