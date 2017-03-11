/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */
var fileReport;
$(document).ready(function () {
    fileReport = new FileReport(application);
});

function FileReport(application) {

    var self = this;
    var application = application;

    (function init() {
        bindTagsList();
    })();

    function bindTagsList() {
        var tagsInput = $('#form').find('#tags');
        var periodInit = $('#form').find('#periodInit');
        var periodEnd = $('#form').find('#periodEnd');
        tagsInput.tagit({
            allowSpaces: true,
            placeholderText: i18n.FILE_TAGS_LABEL
        });
        application.bindDatePicker(periodInit);
        application.bindDatePicker(periodEnd);
    };
}
