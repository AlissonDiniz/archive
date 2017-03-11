/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var application;
$(function(){
    application = new Application();
});

function Application(){
    
    var searchTimeout = null;
    var searchFunction = null;
    var self = this;
    var validator = new Validator();
    var dateUtil = new DateUtil();
    
    (function init(){
        bindLinkLine();
        bindValidateForm();
        bindButtonSubmit();
        bindButtonConfirmSubmit();
        bindButtonRedirect();
        bindSearchInput();
        bindMaskInputDate();
        fadeAlertMessages();
    })();
    
    function bindLinkLine(){
        $('table tbody tr.link').click(function(){
            var path = $(this).data('path');
            location.href = path;
        });
    };
    
    function bindMaskInputDate(){
        $('input.mask-date').mask("99/99/9999", { placeholder: i18n.DEFAULT_DATE_FORMAT });
    };
    
    function bindValidateForm(){
        var inputs = $('form').find("input.validate");
        inputs.blur(function(){
            validator.validate($(this));
        });
        inputs.keyup(function(e){
            var keyCode = e.keyCode;
            if(keyCode === 9){
                return;
            }
            validator.validate($(this));
        });
        var dropDowns = $('form').find("select.validate");
        dropDowns.blur(function(){
            validator.validate($(this));
        });
        dropDowns.change(function(){
            validator.validate($(this));
        });
    };
    
    function bindButtonSubmit(){
        $('.buttons .btn.submit').click(function(){
            var form = $("#"+$(this).data("form"));
            var valid = true;
            var inputs = form.find("input.validate");
            var dropDowns = form.find("select.validate");
            $.each(inputs, function(){
                var inputValid = validator.validate($(this));
                if(!inputValid){
                   valid = false; 
                }
            });
            $.each(dropDowns, function(){
                var inputValid = validator.validate($(this));
                if(!inputValid){
                   valid = false; 
                }
            });
            if(valid){
                ShowWait();
                form.submit();
            }
        });
        $('.buttons .btn.submit-report').click(function(){
            var form = $("#"+$(this).data("form"));
            form.submit();
        });
    };
    
    function bindButtonConfirmSubmit(){
        $('.buttons .btn.confirm-submit').click(function(){
            var form = $("#"+$(this).data("form"));
            $("#dialog-message").html($(this).data("message"));
            $("#dialog-message").dialog({modal: true, buttons: {
                OK: function() {
                    ShowWait();
                    form.submit();
                },
                Cancel: function() {
                    $(this).dialog("close");
                }
            }});
        });
    };
    
    function bindButtonRedirect(){
        $('.buttons .btn.redirect').click(function(){
            location.href = $(this).data("path");
        });
    };
    
    function bindSearchInput(){
        var searchWrapper = $('.search-wrapper:not(.custom-search)');
        var placeholder = searchWrapper.find(".placeholder-button");
        var cleanButton = searchWrapper.find(".clean-button");
        cleanButton.click(function(){location.reload();});
        searchWrapper.find('input#search-field').keyup(function() {
            var term = $(this).val();
            if(term){
                placeholder.hide();
                cleanButton.show();
            }else{
                location.reload();
            }
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(function() {
                if(searchFunction){
                    searchFunction(term);
                }
            }, 800);
        });
    };
    
    function injectHtmlResult(createLine, data){
        var isOdd = false;
        var template = "";
        $.each(data, function(index, secUser){
            template += createLine(secUser, isOdd);
            isOdd = isOdd ? false : true;
        });
        $(".pagination").hide();
        $(".table thead th.sortable").removeClass("sortable").find("a").removeAttr("href");
        $(".table tbody").html(template);
        bindLinkLine();
    }
    
    function fadeAlertMessages(){
        $(".alert.alert-success").fadeOut(4000);
    };
    
    function logout(){
        $("#logoutForm").submit();
    };

    function ShowMessage(message) {
        if($("#dialog-wait").is(":visible")){
            $("#dialog-wait").dialog("close");
        }
        $("#dialog-message").html(message);
        $("#dialog-message").dialog({modal: true, buttons: {Ok: function() {
            $(this).dialog("close");
        }}});
    };

    function ShowWait() {
        $("#dialog-wait").dialog({modal: true});
    };

    function CloseWait() {
        $("#dialog-wait").dialog("close");
    };
    
    function confirmFunction(callback, message){
        $("#dialog-message").html(message);
        $("#dialog-message").dialog({modal: true, buttons: {
            OK: function() {
                $(this).dialog("close");
                ShowWait();
                callback();
            },
            Cancel: function() {
                $(this).dialog("close");
            }
        }});
    };
    
    function changePassword(){
        var modal = $('#dialog-changePassword');
        modal.dialog({modal: true, width: 400});
        var saveButton = modal.find('.save-button');
        var cancelButton = modal.find('.cancel-button');
        var oldPassword = modal.find('#oldPassword');
        var newPassword = modal.find('#newPassword');
        saveButton.click(function(){
            var form = modal.find('.form');
            var valid = true;
            var inputs = form.find("input.validate");
            $.each(inputs, function(){
                var inputValid = validator.validate($(this));
                if(!inputValid){
                   valid = false; 
                }
            });
            if(valid){
                ShowWait();
                $.ajax({
                    url: "/archive/secUser/changePassword",
                    type: "POST",
                    data: {oldPassword: oldPassword.val(), newPassword: newPassword.val()}
                }).done(function () {
                    modal.dialog("close");
                }).fail(function (xhr) {
                    if (xhr.status === 403) {
                        ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
                    } else if (xhr.status === 406) {
                        ShowMessage(i18n.SECUSER_OLDPASSWORD_INVALID);
                    } else {
                        ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
                    }
                }).always(function(){CloseWait();});
            }
        });
        cancelButton.click(function(){
            modal.dialog("close");
        });
    };
    
    function getObject(array, id){
        var object = null;
        $.each(array, function(index, item){
            if(id === item.id){
                object = item;
            }
        });
        return object;
    };
    
    function removeObject(array, id){
        $.each(array, function(index, item){
            if(id === item){
                array.splice(index, 1);
            }
        });
    };
    
    function bindDatePicker(input){
        if(input){
            input.datepicker({
                format: i18n.DEFAULT_DATE_FORMAT
            });
        }
    };
    
    function bindKeyUp(input, enter, esc) {
        input.keyup(function (e) {
            var keyCode = e.keyCode;
            if ($(this).val()) {
                $(this).parent().removeClass('has-error');
                if(keyCode === 13){
                    enter();
                }
            } else {
                $(this).parent().addClass('has-error');
            }
            if(keyCode === 27){
                esc();
            }
        });
    };
    
    self.logout = logout;
    self.setSearchFunction = function(searchFunc){searchFunction = searchFunc;};
    self.injectHtmlResult = injectHtmlResult;
    self.ShowWait = ShowWait;
    self.CloseWait = CloseWait;
    self.ShowMessage = ShowMessage;
    self.dateUtil = dateUtil;
    self.confirmFunction = confirmFunction;
    self.getObject = getObject;
    self.removeObject = removeObject;
    self.bindLinkLine = bindLinkLine;
    self.changePassword = changePassword;
    self.bindDatePicker = bindDatePicker;
    self.bindKeyUp = bindKeyUp;
};
