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
    if (clicks === 0) {
        document.getElementById("mobile_nav").style.visibility = "visible";
        document.getElementById("mobile_nav").style.opacity = "1";
        document.getElementById("mobile_nav").style.zIndex = "5";
        document.getElementById("bar1").style.border = "none";
        document.getElementById("bar3").style.border = "none";
        x.classList.toggle("change");
        clicks = 1;
    }

    else if (clicks === 1) {
        document.getElementById("mobile_nav").style.visibility = "hidden";
        document.getElementById("mobile_nav").style.opacity = "0";
        document.getElementById("mobile_nav").style.zIndex = "0";
        document.getElementById("bar1").style.border = "1px solid black";
        document.getElementById("bar3").style.border = "1px solid black";
        x.classList.toggle("change");
        clicks = 0;
    }
}

function remove_flash() {
window.setTimeout(function() {
    document.getElementById("notification").style.display= "none";
}, 5000);
}

function confirmEditUser(currentEmail) {
    var form = document.getElementById('edit_user_form');
    var email_field = document.getElementById('user_email').value;
    if(currentEmail === email_field) {
        form.submit();
    } else {
        $.confirm({
            title: 'Changing Email Address',
            content: 'Your email address change will only take effect once you click on the link sent to the new email.' +
            'You can sign in with your old address until then.<br/><br/>Click confirm to proceed (You will be logged out)',
            buttons: {
                confirm: {
                    btnClass: 'pop_up_confirm',
                    action: function() {form.submit();}
                },
                cancel: function () {},
            }
        });
    }

}