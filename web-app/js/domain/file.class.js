/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */
var file;
$(document).ready(function () {
    file = new File(application);
});

function File(application) {

    var self = this;
    var application = application;
    var treeStorage = null;
    var treeClassification = null;
    var fileList = $('#file-table');
    var fileObjectList = [];
    var selectedNode = null;
    var expandNodeList = new Array();
    var service = new FileService(application);
    var validator = new Validator();

    (function init() {
        treeStorage = new TreeNode(application, $('#storagePlant'));
        var callbackStorage = function(data){
            treeStorage.init(data);
            treeStorage.setSelectedNodeCustom(selectStorageNode);
            treeStorage.setUnSelectedNodeCustom(function() {$('#fileListOverlay').show(); fileList.find('tbody').empty(); });
            treeStorage.initFilterNode($('#searchWrapperStorage'));
        };
        service.listStorage(callbackStorage);
        
        treeClassification = new TreeNode(application, $('#treeClassification'));
        var callbackClassification = function(data){
            treeClassification.init(data);
            treeClassification.setSelectedNodeCustom(enableNextButton);
            treeClassification.setUnSelectedNodeCustom(disableNextButton);
            treeClassification.initFilterNode($('#searchWrapperClassification'));
        };
        service.listClassification(callbackClassification);
        bindAddFile();
        bindSearchFile();
        bindUpdateFile();
    })();
    
    function bindAddFile(){
        var modal = $("#addFileModal");
        var classificationContainer = modal.find('.classification-container');
        var nextButton = classificationContainer.find('.next-button');
        var cancelButton = classificationContainer.find('.cancel-button');
        var fileContainer = modal.find('.file-container');
        var previousButton = fileContainer.find('.previous-button');
        var saveButton = fileContainer.find('.save-button');
        var codeInput = fileContainer.find('#code');
        var nameInput = fileContainer.find('#name');
        var periodInitInput = fileContainer.find('#periodInit');
        var periodEndInput = fileContainer.find('#periodEnd');
        var tagsInput = fileContainer.find('#tags');
        $('#add-file button').click(function(){
            modal.dialog({
                modal: true,
                width: 800
            });
        });
        nextButton.click(function(){
            var classification = treeClassification.getSelectedNode();
            var callback = function(lastCode){
                classificationContainer.hide();
                fileContainer.show('slow');
                codeInput.val(treeClassification.getSelectedNode().data('code') + '-' + lastCode);
                nameInput.focus();
            };
            service.getLastFileCode(classification.data('id'), callback);
        });
        cancelButton.click(function(){
            modal.dialog("close");
        });
        previousButton.click(function(){
            fileContainer.hide();
            classificationContainer.show('slow');
        });
        saveButton.click(function(){
            save();
        });
        bindKeyUp(codeInput);
        bindKeyUp(nameInput);
        tagsInput.tagit({
            allowSpaces: true,
            placeholderText: i18n.FILE_TAGS_LABEL
        });
        application.bindDatePicker(periodInitInput);
        application.bindDatePicker(periodEndInput);
    };
    
    function selectStorageNode(){
        var modal = $("#addFileModal");
        $('#fileListOverlay').hide();
        loadFiles();
    };
    
    function bindUpdateFile(){
        var modal = $('#editFileModal');
        var fileContainer = modal.find('.file-container');
        var cancelButton = fileContainer.find('.cancel-button');
        var saveButton = fileContainer.find('.save-button');
        cancelButton.click(function(){
            modal.dialog("close");
        });
        saveButton.click(function(){
            update();
        });
    };
    
    function bindSelectFile(){
        var modal = $('#editFileModal');
        var fileContainer = modal.find('.file-container');
        var codeInput = fileContainer.find('#code');
        var nameInput = fileContainer.find('#name');
        var periodInitInput = fileContainer.find('#periodInitEdit');
        var periodEndInput = fileContainer.find('#periodEndEdit');
        var subjectInput = fileContainer.find('#subject');
        var typeInput = fileContainer.find('#type');
        var containerTags = fileContainer.find('#container-tags');
        var noteInput = fileContainer.find('#note');
        fileList.find('tbody tr.file').click(function(e){
            var fileId = $(this).data('id');
            if(!$(e.currentTarget).hasClass('trigger-remove')){
                var file = application.getObject(fileObjectList, fileId);
                codeInput.val(file.code);
                nameInput.val(file.name);
                periodInitInput.val(application.dateUtil.formatDate(file.periodInit));
                periodEndInput.val(application.dateUtil.formatDate(file.periodEnd));
                subjectInput.val(file.subject);
                typeInput.val(file.typeId);
                containerTags.empty();
                var tagsInput = $('<input name="tags" id="tags" value="" disabled="true">');
                containerTags.append(tagsInput);
                tagsInput.val(file.tagList);
                tagsInput.tagit({
                    allowSpaces: true,
                    placeholderText: i18n.FILE_TAGS_LABEL
                });
                noteInput.val(file.note);
                modal.dialog({
                    modal: true,
                    width: 800
                });
                modal.data('file-id', fileId);
            }
        });
        application.bindDatePicker(periodInitInput);
        application.bindDatePicker(periodEndInput);
    };
    
    function loadFiles(){
        var storageId = treeStorage.getSelectedNode().data('id');
        var callback = function(data){
            fileObjectList = data;
            renderFiles(data);
            bindSelectFile();
            bindRemoveFile();
        };
        service.list(storageId, callback);
    };
    
    function renderFiles(data){
        var tbody = fileList.find('tbody');
        tbody.empty();
        $.each(data, function (index, item) {
            var line = $('<tr id="file-' + item.id + '" data-id="' + item.id + '" data-code="' + item.code + '" class="file"></tr>');
            var codeColumn = $('<td class="code">' + item.code + '</td>');
            var nameColumn = $('<td class="name">' + item.name + '</td>');
            if(!item.subject){
                item.subject = "";
            }
            var subjectColumn = $('<td class="subject">' + item.subject + '</td>');
            var typeColumn = $('<td class="type">' + item.type + '</td>');
            var periodColumn = $('<td class="period">' + i18n.DEFAULT_UNDATED_LABEL + '</td>');
            if(item.periodInit || item.periodEnd){
                var periodInit = item.periodInit ? application.dateUtil.formatDate(item.periodInit) : '';
                var periodEnd = item.periodEnd ? application.dateUtil.formatDate(item.periodEnd) : '';
                periodColumn = $('<td class="period">' + periodEnd + '<br />' +  periodEnd + '</td>');
            }
            var tagList = '';
            if(item.tagList){
                var tagArray = item.tagList.split(',');
                $.each(tagArray, function(index, tag){
                    tagList = tagList + '<span class="tag">' + tag + '</span>';
                });
            }
            var tagsColumn = $('<td>' + tagList + '</td>');
            var note = item.note === null ? '' : item.note;
            var noteColumn = $('<td class="note">' + note + '</td>');
            var removeColumn = $('<td><i class="trigger-remove fa fa-trash" title="' + i18n.STORAGE_BUTTON_DELETE + '"></i></td>');
            line.append(codeColumn);
            line.append(nameColumn);
            line.append(subjectColumn);
            line.append(typeColumn);
            line.append(periodColumn);
            line.append(tagsColumn);
            line.append(noteColumn);
            line.append(removeColumn);
            tbody.append(line);
        });
    };
    
    function bindRemoveFile(){
        var tbody = fileList.find('tbody');
        tbody.find('tr td .trigger-remove').click(function(){
            var file = $(this).closest('tr.file');
            var callback = function () {
                loadFiles();
            };
            var action = function () {
                service.remove(file.data('id'), callback);
            };
            application.confirmFunction(action, i18n.FILE_CONFIRM_DELETE);
        });
    };
    
    function bindSearchFile(){
        var container = $('#search-file');
        var input = container.find('#search-field'); 
        var searchButton = container.find('.placeholder-button');
        var cancelButton = container.find('.clean-button');
        input.keyup(function(){
            var value = input.val();
            if(value){
                searchButton.hide();
                cancelButton.show();
            }else{
                cancelButton.hide();
                searchButton.show();
            }
            filter(value);
        });
        cancelButton.click(function(){
            cancelFilter();
        });
    };
    
    function cancelFilter(){
        var container = $('#search-file');
        var input = container.find('#search-field'); 
        var searchButton = container.find('.placeholder-button');
        var cancelButton = container.find('.clean-button');
        input.val('');
        cancelButton.hide();
        searchButton.show();
        filter(input.val());  
    };
    
    function filter(term){
        if(term){
            $.each(fileList.find('tbody tr'), function (i, line) {
                var file = $(line);
                var code = file.find('.code').text();
                var name = file.find('.name').text();
                var note = file.find('.note').text();
                var tagList = file.find('.tag');
                var contains = false;

                if(code.toUpperCase().indexOf(term.toUpperCase()) > -1){
                   contains = true; 
                }
                if(name.toUpperCase().indexOf(term.toUpperCase()) > -1){
                   contains = true; 
                }
                if(note.toUpperCase().indexOf(term.toUpperCase()) > -1){
                   contains = true; 
                }
                $.each(tagList, function (i, item) {
                    var tag = $(item);
                    if(tag.text().toUpperCase().indexOf(term.toUpperCase()) > -1){
                        contains = true; 
                    }
                });
                if(contains){
                    file.removeClass('filtered');
                }else{
                    file.addClass('filtered');
                }
            });
        }else{
            fileList.find('tbody tr').removeClass('filtered');
        }
    };
    
    function enableNextButton(){
        var modal = $("#addFileModal");
        modal.find('.next-button').attr('disabled', false);
    };
    
    function disableNextButton(){
        var modal = $("#addFileModal");
        modal.find('.next-button').attr('disabled', true);
    };
    
    function bindKeyUp(input) {
        input.keyup(function () {
            if ($(this).val()) {
                $(this).parent().removeClass('has-error');
            } else {
                $(this).parent().addClass('has-error');
            }
        });
    };
    
    function save(){
        var modal = $("#addFileModal");
        var fileContainer = modal.find('.file-container');
        var codeInput = fileContainer.find('#code');
        var nameInput = fileContainer.find('#name');
        var subjectInput = fileContainer.find('#subject');
        var typeInput = fileContainer.find('#type');
        var tagsInput = fileContainer.find('#tags');
        var periodInitInput = fileContainer.find('#periodInit');
        var periodEndInput = fileContainer.find('#periodEnd');
        var noteInput = fileContainer.find('#note');
        var valid = true;
        $.each(fileContainer.find("input.validate"), function(){
            var inputValid = validator.validate($(this));
            if(!inputValid){
               valid = false; 
            }
        });

        if(valid){
            var file = {parentClassification: treeClassification.getSelectedNode().data('id'), 
                        parentStorage: treeStorage.getSelectedNode().data('id'),
                        code: codeInput.val(), 
                        name: nameInput.val(), 
                        subject: subjectInput.val(), 
                        type: typeInput.val(), 
                        periodInit: periodInitInput.val() ? application.dateUtil.getHttpDate(periodInitInput.val()) : null, 
                        periodEnd: periodEndInput.val() ? application.dateUtil.getHttpDate(periodEndInput.val()) : null, 
                        tagList: tagsInput.val(), 
                        note: noteInput.val()};
            var callback = function(){
                $("#addFileModal").dialog("close");
                cleanFormNewFile();
                loadFiles();
            };
            service.save(file, callback);
        }
    };
    
    function update(){
        var modal = $("#editFileModal");
        var file = application.getObject(fileObjectList, modal.data('file-id'));
        var fileContainer = modal.find('.file-container');
        var codeInput = fileContainer.find('#code');
        var nameInput = fileContainer.find('#name');
        var subjectInput = fileContainer.find('#subject');
        var typeInput = fileContainer.find('#type');
        var tagsInput = fileContainer.find('#tags');
        var periodInitInput = fileContainer.find('#periodInitEdit');
        var periodEndInput = fileContainer.find('#periodEndEdit');
        var noteInput = fileContainer.find('#note');
        var valid = true;
        $.each(fileContainer.find("input.validate"), function(){
            var inputValid = validator.validate($(this));
            if(!inputValid){
               valid = false; 
            }
        });

        if(valid){
            var file = {id: file.id,
                        parentClassification: file.parentClassificationId, 
                        parentStorage: file.parentStorageId,
                        code: codeInput.val(), 
                        name: nameInput.val(), 
                        subject: subjectInput.val(), 
                        type: typeInput.val(), 
                        periodInit: periodInitInput.val() ? application.dateUtil.getHttpDate(periodInitInput.val()) : null, 
                        periodEnd: periodEndInput.val() ? application.dateUtil.getHttpDate(periodEndInput.val()) : null, 
                        tagList: tagsInput.val(), 
                        note: noteInput.val()};
                    console.log(periodInitInput.val());
                    console.log(file);
            var callback = function(){
                modal.dialog("close");
                loadFiles();
                cancelFilter();
            };
            service.update(file, callback);
        }
    };
    
    function cleanFormNewFile(){
        var modal = $("#addFileModal");
        var classificationContainer = modal.find('.classification-container');
        var fileContainer = modal.find('.file-container');
        var codeInput = fileContainer.find('#code');
        var nameInput = fileContainer.find('#name');
        var tagsInput = fileContainer.find('#tags');
        var periodInitInput = fileContainer.find('#periodInit');
        var periodEndInput = fileContainer.find('#periodEnd');
        var noteInput = fileContainer.find('#note');
        classificationContainer.show();
        fileContainer.hide();
        codeInput.val('');
        nameInput.val('');
        tagsInput.tagit("removeAll");
        periodInitInput.val('');
        periodEndInput.val('');
        noteInput.val('');
    };
}
