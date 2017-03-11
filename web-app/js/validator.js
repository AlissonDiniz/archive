/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function Validator(){
    
    var self = this;
    
    function validate(input){
        var inputValid = true;
        if(input.hasClass("required")){
            inputValid = requiredValidate(input);
        }
        if(inputValid && input.hasClass("confirm")){
            var firstInput = $("#"+input.data("field"));
            inputValid = confirmValidate(firstInput, input);
        }
        if(inputValid && input.hasClass("date-picker")){
            var firstInput = $("#"+input.data("field"));
            inputValid = dateValidate(input);
        }
        if(inputValid){
            var container = input.parent();
            container.removeClass("has-error"); 
        }
        return inputValid;
    }

    function requiredValidate(input){
        var valid = true;
        if(!input.val()){
            var container = input.parent();
            container.addClass("has-error");
            var label = container.find("label").text().replace("*", "").trim();
            var span = container.find(".form-control-feedback");
            var message = span.data("message-required").replace("%", label);
            span.attr("title", message);
            valid = false;
        }
        return valid;
    }

    function confirmValidate(inputFirst, inputSecond){
        var valid = true;
        if(inputFirst.val() !== inputSecond.val()){
            var container = inputSecond.parent();
            var firstLabel = inputFirst.parent().find("label").text().replace("*", "").trim();
            var secondLabel = inputSecond.parent().find("label").text().replace("*", "").trim();
            container.addClass("has-error");
            var span = container.find(".form-control-feedback");
            var message = span.data("message-confirm").replace("%", firstLabel).replace("%", secondLabel);
            span.attr("title", message);
            valid = false;
        }
        return valid;
    };
    
    function dateValidate(input){
        var valid = true;
        if(input.val() && !moment(input.val(), i18n.DEFAULT_DATE_FORMAT, true).isValid()){
            var container = input.parent();
            container.addClass("has-error");
            var span = container.find(".form-control-feedback");
            var message = span.data("message-date-picker");
            span.attr("title", message);
            valid = false;
        }
        return valid;
    };
    
    self.validate = validate;
}