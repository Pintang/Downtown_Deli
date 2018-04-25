/*!
 * Start Bootstrap - SB Admin 2 v3.3.7+1 (http://startbootstrap.com/template-overviews/sb-admin-2)
 * Copyright 2013-2016 Start Bootstrap
 * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap/blob/gh-pages/LICENSE)
 */
$(function () {
    $('#side-menu').metisMenu();
});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function () {
    $(window).bind("load resize", function () {
        var topOffset = 50;
        var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        var height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    // var element = $('ul.nav a').filter(function() {
    //     return this.href == url;
    // }).addClass('active').parent().parent().addClass('in').parent();
    var element = $('ul.nav a').filter(function () {
        return this.href == url;
    }).addClass('active').parent();

    while (true) {
        if (element.is('li')) {
            element = element.parent().addClass('in').parent();
        } else {
            break;
        }
    }
    SetupDatePickers();
    var ctx = document.getElementById("myChart");
    if (ctx != null) {
        ctx = document.getElementById("myChart").getContext('2d');

        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["Tyler", "Cole", "Craig", "Tim", "Omar"],
                datasets: [{
                    label: '= 1 Sale',
                    data: [12, 19, 3, 5, 2],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    }
    var ctxP = document.getElementById("pieChart");
    if (ctxP != null) {
        var ctxP = document.getElementById("pieChart").getContext('2d');
        var myPieChart = new Chart(ctxP, {
            type: 'pie',
            data: {
                labels: ["Tyler", "Cole", "Craig", "Tim", "Omar"],
                datasets: [
                    {
                        data: [250, 50, 100, 90, 150],
                        backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#949FB1", "#4D5360"],
                        hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#A8B3C5", "#616774"]
                    }
                ]
            },
            options: {
                responsive: true
            }
        });
    }
});

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('lblTime').innerHTML =
        h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
}
function checkTime(i) {
    if (i < 10) { i = "0" + i };
    return i;
}
function OpenModal(ModalID) {
    $('#' + ModalID).modal('toggle');
}
function ValidateNewInventory() {
    var tbItemName = document.getElementById('Body_tbItemName');
    var tbNewQuantity = document.getElementById('Body_tbNewQuantity');
    var tbdate = document.getElementById('Body_ExpDateTimePickerInput');
    var tbCost = document.getElementById('Body_tbCost');
    var btnAddNew = document.getElementById('Body_btnAddNew');
    var lblErrorAddNewModal = document.getElementById('Body_lblErrorAddNewModal');
    if (tbItemName.value != '') {
        if (tbNewQuantity.value != '') {
            if (tbCost.value != '') {
                if (tbdate.value != '') {
                    btnAddNew.click();
                } else {
                    lblErrorAddNewModal.innerHTML = 'Expiration Date is required';
                }
            } else {
                lblErrorAddNewModal.innerHTML = 'Cost is required';
            }
        } else {
            lblErrorAddNewModal.innerHTML = 'Quantity is required';
        }
    } else {
        lblErrorAddNewModal.innerHTML = 'Item name is required.';
    }
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
function ValidateModifyInventory() {
    var tbQuantity = document.getElementById('Body_tbQuantity');
    var btnUpdate = document.getElementById('Body_btnUpdate');
    if (tbQuantity.value != '') {
        btnUpdate.click();
    } else {
        lblErrorModify.innerhtml = 'Quantity is required';
    }
}


function ValidateModifyMenuItem() {
    var tbPrice = document.getElementById('Body_txtMenuItemPrice');
    var btnUpdate = document.getElementById('Body_btnUpdateMenuItem');
    var lblErrorMenuItemModify = document.getElementById('Body_lblErrorMenuItemModify');
    if (tbPrice.value != '') {
        btnUpdate.click();
    } else {
        lblErrorMenuItemModify.innerHTML = 'Price is required';
    }
}
function ValidateNewMenuItem() {
    var tbPrice = document.getElementById('Body_tbNewMenuPrice');
    var tbName = document.getElementById('Body_tbMenuItemNameNew');
    var btnUpdate = document.getElementById('Body_btnAddNewMenuItem');
    var lblNewMenuItemError = document.getElementById('Body_lblNewMenuItemError');
    if (tbPrice.value != '') {
        if (tbName.value != '') {
            btnUpdate.click();
        } else {
            lblNewMenuItemError.innerHTML = 'Name is required';
        }
    } else {
        lblNewMenuItemError.innerHTML = 'Price is required';
    }
}

function ValidateModifyEmployee() {
    var txtFirstnameModify = document.getElementById('Body_txtFirstnameModify');
    var txtLastnameModify = document.getElementById('Body_txtLastnameModify');
    var txtPayModify = document.getElementById('Body_txtPayModify');
    var txtPhoneModify = document.getElementById('Body_txtPhoneModify');
    var txtEmailModify = document.getElementById('Body_txtEmailModify');
    var txtAddressModify = document.getElementById('Body_txtAddressModify');
    var txtUsername = document.getElementById('Body_txtUsername');
    var lblErrorEmployeeModify = document.getElementById('Body_lblErrorEmployeeModify');
    var btnUpdate = document.getElementById('Body_btnUpdateEmployee');
    if (txtFirstnameModify.value != '') {
        if (txtLastnameModify.value != '') {
            if (txtPayModify.value != '') {
                if (txtPhoneModify.value != '') {
                    if (txtEmailModify.value != '') {
                        if (txtAddressModify.value != '') {
                            if (txtUsername.value != '') {
                                btnUpdate.click();
                            } else {
                                lblErrorEmployeeModify.innerHTML = 'Username is required';
                            }
                        } else {
                            lblErrorEmployeeModify.innerHTML = 'Address is required';
                        }
                    } else {
                        lblErrorEmployeeModify.innerHTML = 'Email is required';
                    }
                } else {
                    lblErrorEmployeeModify.innerHTML = 'Phone number is required';
                }
            } else {
                lblErrorEmployeeModify.innerHTML = 'Pay rate is required';
            }
        } else {
            lblErrorEmployeeModify.innerHTML = 'Last name is required';
        }
    } else {
        lblErrorEmployeeModify.innerHTML = 'First name is required';
    }
}

function ValidateNewEmployee() {
    var txtFirstnameModify = document.getElementById('Body_txtFirstNameNew');
    var txtLastnameModify = document.getElementById('Body_txtlastNameNew');
    var txtPayModify = document.getElementById('Body_txtPayNew');
    var txtPhoneModify = document.getElementById('Body_txtPhoneNew');
    var txtEmailModify = document.getElementById('Body_txtEmailNew');
    var txtAddressModify = document.getElementById('Body_txtAddressNew');
    var txtUsername = document.getElementById('Body_txtUsernameNew');
    var txtPassword = document.getElementById('Body_txtPasswordNew');
    var lblErrorEmployeeModify = document.getElementById('Body_lblerrorNewEMployee');
    var btnUpdate = document.getElementById('Body_btnNewEmployee');
    if (txtFirstnameModify.value != '') {
        if (txtLastnameModify.value != '') {
            if (txtPayModify.value != '') {
                if (txtPhoneModify.value != '') {
                    if (txtEmailModify.value != '') {
                        if (txtAddressModify.value != '') {
                            if (txtUsername.value != '') {
                                if (txtPassword.value != '') {
                                    btnUpdate.click();
                                } else {
                                    lblErrorEmployeeModify.innerHTML = 'Password is required';
                                }
                            } else {
                                lblErrorEmployeeModify.innerHTML = 'Username is required';
                            }
                        } else {
                            lblErrorEmployeeModify.innerHTML = 'Address is required';
                        }
                    } else {
                        lblErrorEmployeeModify.innerHTML = 'Email is required';
                    }
                } else {
                    lblErrorEmployeeModify.innerHTML = 'Phone number is required';
                }
            } else {
                lblErrorEmployeeModify.innerHTML = 'Pay rate is required';
            }
        } else {
            lblErrorEmployeeModify.innerHTML = 'Last name is required';
        }
    } else {
        lblErrorEmployeeModify.innerHTML = 'First name is required';
    }
}

function ValidateModifyPromo() {
    var tbDicountNew = document.getElementById('Body_tbDicountNew');
    var dpBeginDatePickerNewInput = document.getElementById('Body_dpBeginDatePickerNewInput');
    var dpEndDatePickerNewInput = document.getElementById('Body_dpEndDatePickerNewInput');
    var tbPromDescModify = document.getElementById('Body_tbPromoDescNew');
    var lblErrorPromoNew = document.getElementById('Body_lblErrorPromoNew');
    var btnUpdate = document.getElementById('Body_btnNewPromo');
    if (tbDicountNew.value != '') {
        if (dpBeginDatePickerNewInput.value != '') {
            if (dpEndDatePickerNewInput.value != '') {
                if (tbPromDescModify.value != '') {
                    btnUpdate.click();
                } else {
                    lblErrorModifyPromo.innerHTML = 'Description is required';
                }
            } else {
                lblErrorPromoNew.innerHTML = 'End Date is required';
            }
        } else {
            lblErrorPromoNew.innerHTML = 'Begin Date is required';
        }
    } else {
        lblErrorPromoNew.innerHTML = 'Discount is required';
    }
}
function ValidateModifyPromo() {
    var tbDicountNew = document.getElementById('Body_tbDiscountModify');
    var dpBeginDatePickerNewInput = document.getElementById('Body_dpBeginDatePickerModifyInput');
    var dpEndDatePickerNewInput = document.getElementById('Body_dpEndDatePickerModifyInput');
    var tbPromDescModify = document.getElementById('Body_tbPromDescModify');
    var lblErrorModifyPromo = document.getElementById('Body_lblErrorModifyPromo');
    var btnUpdate = document.getElementById('Body_btnUpdatePromo');
    if (tbDicountNew.value != '') {
        if (dpBeginDatePickerNewInput.value != '') {
            if (dpEndDatePickerNewInput.value != '') {
                if (tbPromDescModify.value != '') {
                    btnUpdate.click();
                } else {
                    lblErrorModifyPromo.innerHTML = 'Description is required';
                }
            } else {
                lblErrorModifyPromo.innerHTML = 'End Date is required';
            }
        } else {
            lblErrorModifyPromo.innerHTML = 'Begin Date is required';
        }
    } else {
        lblErrorModifyPromo.innerHTML = 'Discount is required';
    }
}

function ValidateNewVendor() {
    var txtVendorNameNew = document.getElementById('Body_txtVendorNameNew');
    var txtVendorDiscountNew = document.getElementById('Body_txtVendorDiscountNew');
    var txtVendorAddressNew = document.getElementById('Body_txtVendorAddressNew');
    var lblVendorNewError = document.getElementById('Body_lblVendorNewError');
    var btnUpdate = document.getElementById('Body_btnAddVendor');
    if (txtVendorNameNew.value != '') {
        if (txtVendorDiscountNew.value != '') {
            if (txtVendorAddressNew.value != '') {
                btnUpdate.click();
            } else {
                lblVendorNewError.innerHTML = 'Address is required';
            }
        } else {
            lblVendorNewError.innerHTML = 'Discount is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Name is required';
    }
}
function ValidateModifyVendor() {
    var txtVendorNameNew = document.getElementById('Body_txtVendorNameModify');
    var txtVendorDiscountNew = document.getElementById('Body_txtDiscountVendorModify');
    var txtVendorAddressNew = document.getElementById('Body_txtVendorAddress');
    var lblVendorNewError = document.getElementById('Body_lblVendorModifyError');
    var btnUpdate = document.getElementById('Body_btnUpdateVendor');
    if (txtVendorNameNew.value != '') {
        if (txtVendorDiscountNew.value != '') {
            if (txtVendorAddressNew.value != '') {
                btnUpdate.click();
            } else {
                lblVendorNewError.innerHTML = 'Address is required';
            }
        } else {
            lblVendorNewError.innerHTML = 'Discount is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Name is required';
    }
}


function ValidateNewJob() {
    var tbJobNameNew = document.getElementById('Body_tbJobNameNew');
    var txtJobDutiesNew = document.getElementById('Body_txtJobDutiesNew');
    var lblVendorNewError = document.getElementById('Body_lblErrorNewJob');
    var btnUpdate = document.getElementById('Body_btnAddNewJob');
    if (tbJobNameNew.value != '') {
        if (txtJobDutiesNew.value != '') {
            btnUpdate.click();
        } else {
            lblVendorNewError.innerHTML = 'Duties is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Name is required';
    }
}
function ValidateModifyJob() {
    var tbJobNameNew = document.getElementById('Body_txtJobNameModify');
    var txtJobDutiesNew = document.getElementById('Body_txtJobDutiesModify');
    var lblVendorNewError = document.getElementById('Body_lblErrorJobModify');
    var btnUpdate = document.getElementById('Body_btnJobpdate');
    if (tbJobNameNew.value != '') {
        if (txtJobDutiesNew.value != '') {
            btnUpdate.click();
        } else {
            lblVendorNewError.innerHTML = 'Duties is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Name is required';
    }
}

function ValidateNewSchedule() {
    var txtShiftStartNew = document.getElementById('Body_txtShiftStartNew');
    var txtShiftEndNew = document.getElementById('Body_txtShiftEndNew');
    var txtDescriptionNew = document.getElementById('Body_txtDescriptionNew');
    var lblVendorNewError = document.getElementById('Body_lblErrorSchModify');
    var btnUpdate = document.getElementById('Body_btnAddNewSchedule');
    if (txtShiftStartNew.value != '') {
        if (txtShiftEndNew.value != '') {
            if (txtDescriptionNew.value != '') {
                btnUpdate.click();
            } else {
                lblVendorNewError.innerHTML = 'Description is required';
            }
        } else {
            lblVendorNewError.innerHTML = 'End Shift is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Start Shift is required';
    }
}

function ValidateModifySchedule() {
    var txtShiftStartNew = document.getElementById('Body_txtShiftStartModify');
    var txtShiftEndNew = document.getElementById('Body_txtShiftEndModify');
    var txtDescriptionNew = document.getElementById('Body_txtDescriptionModify');
    var lblVendorNewError = document.getElementById('Body_lblErrorScheduleModify');
    var btnUpdate = document.getElementById('Body_btnUpdateSchedule');
    if (txtShiftStartNew.value != '') {
        if (txtShiftEndNew.value != '') {
            if (txtDescriptionNew.value != '') {
                btnUpdate.click();
            } else {
                lblVendorNewError.innerHTML = 'Description is required';
            }
        } else {
            lblVendorNewError.innerHTML = 'End Shift is required';
        }
    } else {
        lblVendorNewError.innerHTML = 'Start Shift is required';
    }
}
function SetupDatePickers() {
    var dp = $("#ExpDateTimePicker");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_ExpDateTimePickerInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#dpBeginDatePickerNew");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_dpBeginDatePickerNewInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#dpBeginDatePickerModify");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_dpBeginDatePickerModifyInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#dpEndDatePickerModify");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_dpEndDatePickerModifyInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#dpEndDatePickerNew");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_dpEndDatePickerNewInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#StartDateDatePickerReports");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_StartDateDatePickerReportsInput');
        nodes.value = ev.target.value;
    });

    var dp = $("#StopDateDatePickerReports");
    dp.on('change', function (ev) {
        var nodes = document.getElementById('Body_StopDateDatePickerReportsInput');
        nodes.value = ev.target.value;
    });
    $('#ExpDateTimePicker').datetimepicker({ dateFormat: 'mm/dd/yyyy' });
    $('#dpBeginDatePickerNew').datetimepicker({ dateFormat: 'mm/dd/yyyy' });
    $('#dpBeginDatePickerModify').datetimepicker({ dateFormat: 'mm/dd/yyyy' });
    $('#dpEndDatePickerNew').datetimepicker({ dateFormat: 'mm/dd/yyyy' });
    $('#dpEndDatePickerModify').datetimepicker({ dateFormat: 'mm/dd/yyyy' });


    $('#StartDateDatePickerReports').datetimepicker({ dateFormat: 'mm/dd/yyyy' });
    $('#StopDateDatePickerReports').datetimepicker({ dateFormat: 'mm/dd/yyyy' });


    $('#StartTimePicker').datetimepicker();
    $('#StopDateTimePicker').datetimepicker();
}