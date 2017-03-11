/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */
var storage;
$(document).ready(function () {
    storage = new Storage(application);
});

function Storage(application) {

    var self = this;
    var application = application;
    var treeStorage = new TreeNode(application, $('.tree-table'));
    var service = new StorageService(application);
    var initialize = false;

    (function init() {
        initTree();
        bindNewNode();
    })();
    
    function initTree() {
        var initFunction = function(data){
            var renderFunction = function(){
                render(data);
            }
            treeStorage.initCustom(renderFunction);
            if(!initialize){
                treeStorage.setSelectedNodeCustom(cancelNewNode);
                treeStorage.setUnSelectedNodeCustom(cancelNewNode);
                treeStorage.initFilterNode($('#searchWrapper'));
                initialize = true;
            }
            bindEditType();
            bindEditName();
            bindRemoveNode();
        };
        service.list(initFunction);
    };

    function render(data) {
        var tbody = treeStorage.tree.find('tbody');
        tbody.empty();
        $.each(data, function (index, item) {
            var root = item.parentId ? 'parent-' + item.parentId : 'root';
            var id = item.parentId ? 'node-' + item.parentId + '-' + item.id : 'node-' + item.id;
            var line = $('<tr id="' + id + '" data-id="' + item.id + '" data-code="' + item.code + '" class="line-node ' + root + ' hide"></tr>');
            var disabled = 'disabled';
            if(item.canDelete){
                disabled = '';
            }
            var labelType = '<span class="label label-type ignore" data-input="' + item.typeId + '">' + item.code + ' - ' + item.type + '</span>';
            var labelName = '<span class="label label-name ignore" data-input="' + item.name + '">' + item.name + '</span>';
            var firstColumn = $('<td class="node"><i class="trigger fa fa-angle-right"></i>' + labelType + labelName + '</td>');
            var secondColumn = $('<td class="remove-node"><i class="trigger fa fa-trash ' + disabled + '" title="' + i18n.STORAGE_BUTTON_DELETE + '"></i></td>');
            line.append(firstColumn);
            line.append(secondColumn);
            tbody.append(line);
        });
    };

    function bindNewNode() {
        treeStorage.tree.find('thead .add-node').click(function () {
            $(this).attr('disabled', true);
            var tbody = treeStorage.tree.find('tbody');
            var newNode = $('<tr id="node-new" class="line-node new root"></tr>');
            var firstColumn = $('<td class="node"></td>');

            var codeInput = $('<input type="text" id="newNode-code" class="form-control" disabled="disabled"/>');
            var groupCode = $('<div class="form-group col-xs-1"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" aria-hidden="true"></span></div>');
            groupCode.prepend(codeInput);
            var typeInput = $('#storageType').clone();
            typeInput.attr('id', 'newNode-type');
            var groupType = $('<div class="form-group col-xs-2"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" aria-hidden="true"></span></div>');
            groupType.prepend(typeInput);
            var nameInput = $('<input type="text" id="newNode-name" placeholder="' + i18n.STORAGE_NAME_LABEL + '" class="form-control"/>');
            application.bindKeyUp(nameInput,save, cancelNewNode);
            var groupName = $('<div class="form-group col-xs-7"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="' + i18n.DEFAULT_FIELD_REQUIRED.replace('%', i18n.STORAGE_NAME_LABEL) + '" aria-hidden="true"></span></div>');
            groupName.prepend(nameInput);

            firstColumn.append(groupCode);
            firstColumn.append(groupType);
            firstColumn.append(groupName);

            var lastColumn = $('<td class="add-node"></td>');
            var buttonSave = $('<i class="trigger fa fa-check" title="' + i18n.STORAGE_BUTTON_CREATE + '"></i>');
            bindSave(buttonSave);
            var buttonCancel = $('<i class="trigger fa fa-remove" title="' + i18n.DEFAULT_BUTTON_CANCEL_LABEL + '"></i>');
            bindCancel(buttonCancel);

            lastColumn.append(buttonSave);
            lastColumn.append(buttonCancel);

            newNode.append(firstColumn);
            newNode.append(lastColumn);

            var selectedNode = treeStorage.getSelectedNode();
            if (selectedNode) {
                selectedNode.find('.trigger').removeClass('disabled');
                treeStorage.expand(selectedNode);
                selectedNode.after(newNode);
                var code = selectedNode.data('code');
                var children = treeStorage.getChildren(selectedNode, false);
                var childCode = code + '.' + (children.length + 1);
                codeInput.val(code + '.' + (children.length + 1));
                newNode.find('td').eq(0).css('padding-left', (parseInt(selectedNode.find('td').eq(0).css('padding-left').replace('px', '')) + 15) + 'px');
            } else {
                codeInput.val(tbody.find('tr.root').length + 1);
                tbody.append(newNode);
            }
            nameInput.focus();
        });
    };

    function bindSave(buttonSave) {
        buttonSave.click(function () {
            save();
        });
    };

    function bindEditType(){
        treeStorage.tree.find('tbody tr td span.label.label-type').click(function(){
            var span = $(this);
            var td = span.parent();
            var tr = td.parent();
            var div = $('<div class="form-group col-xs-6 div-select-type ignore"></div>');
            var typeInput = $('#storageType').clone();
            typeInput.attr('id', 'type-'+tr.data('id'));
            typeInput.val(span.data('input'));
            typeInput.addClass('ignore');
            typeInput.change(function(){
                var storage = {id: tr.data('id'), type: typeInput.val()}
                var callback = function () {
                    initTree();
                };
                service.update(storage, callback);
            });
            div.prepend(typeInput);
            span.hide();
            span.after(div);
            var enter = function(){};
            var esc = function(){
                span.show();
                div.remove();
            };
            application.bindKeyUp(typeInput, enter, esc);
            typeInput.blur(function(){
                esc();
            });
            typeInput.focus();
        });
    };
    
    function bindEditName(){
        treeStorage.tree.find('tbody tr td span.label.label-name').click(function(){
            var span = $(this);
            var td = span.parent();
            var div = $('<div class="form-group col-xs-6 ignore"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" aria-hidden="true"></span></div>');
            var input = $('<input type="text" class="form-control ignore" value="' + span.data('input') + '" />');
            var enter = function(){
                var storage = {id: td.parent().data('id'), name: input.val()}
                var callback = function () {
                    initTree();
                };
                service.update(storage, callback);
            };
            var esc = function(){
                span.show();
                div.remove();
            };
            div.prepend(input);
            span.hide();
            td.append(div);
            application.bindKeyUp(input, enter, esc);
            input.blur(function(){
                esc();
            });
            input.focus();
        });
    };
    
    function save(){
        var codeInput = treeStorage.tree.find('tr#node-new input#newNode-code');
        var typeInput = treeStorage.tree.find('tr#node-new select#newNode-type');
        var nameInput = treeStorage.tree.find('tr#node-new input#newNode-name');
        var hasError = false;
        if (!codeInput.val()) {
            codeInput.parent().addClass('has-error');
            hasError = true;
        }
        if (!nameInput.val()) {
            nameInput.parent().addClass('has-error');
            hasError = true;
        }

        if (!hasError) {
            var storage = {code: codeInput.val(), type: typeInput.val(), name: nameInput.val(), owner: 'admin'};
            storage.parentStorage = treeStorage.getSelectedNode() ? treeStorage.getSelectedNode().data('id') : null;
            var callback = function () {
                treeStorage.tree.find('thead .add-node').attr('disabled', false);
                initTree();
            };
            service.save(storage, callback);
        }
    };
    
    function bindCancel(buttonCancel) {
        buttonCancel.click(function () {
            cancelNewNode();
        });
    };

    function cancelNewNode() {
        var selectedNode = treeStorage.getSelectedNode()
        if(selectedNode){
            var children = treeStorage.getChildren(selectedNode, false);
            if (children.length === 0) {
                selectedNode.find('.node .trigger').addClass('disabled');
                application.removeObject(treeStorage.getExpandNodeList(), selectedNode.data('id'));
            }
        }
        treeStorage.tree.find('thead .add-node').attr('disabled', false);
        treeStorage.tree.find('tr#node-new').remove();
    };

    function bindRemoveNode() {
        treeStorage.tree.find('.trigger.fa.fa-trash').click(function () {
            var node = $(this).closest('tr.line-node');
            var callback = function () {
                initTree();
            };
            var action = function () {
                service.remove(node.data('id'), callback);
            };
            application.confirmFunction(action, i18n.STORAGE_CONFIRM_DELETE);
        });
    };

    self.initTree = initTree;
}

