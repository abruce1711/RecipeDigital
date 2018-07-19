
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