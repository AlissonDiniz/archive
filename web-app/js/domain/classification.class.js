/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 29/03/2015, 23:31:23
 Author     : Alisson Diniz
 */
var classification;
$(document).ready(function () {
    classification = new Classification(application);
});

function Classification(application) {

    var self = this;
    var application = application;
    var treeClassification = new TreeNode(application, $('.tree-table'));
    var service = new ClassificationService(application);
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
            treeClassification.initCustom(renderFunction);
            if(!initialize){
                treeClassification.setSelectedNodeCustom(cancelNewNode);
                treeClassification.setUnSelectedNodeCustom(cancelNewNode);
                treeClassification.initFilterNode($('#searchWrapper'));
                initialize = true;
            }
            bindEdit();
            bindRemoveNode();
        };
        service.list(initFunction);
    };

    function render(data) {
        var tbody = treeClassification.tree.find('tbody');
        tbody.empty();
        $.each(data, function (index, item) {
            var root = item.parentId ? 'parent-' + item.parentId : 'root';
            var id = item.parentId ? 'node-' + item.parentId + '-' + item.id : 'node-' + item.id;
            var line = $('<tr id="' + id + '" data-id="' + item.id + '" data-code="' + item.code + '" class="line-node ' + root + ' hide"></tr>');
            var firstColumn = $('<td class="node"><i class="trigger fa fa-angle-right"></i><span class="label" data-input="' + item.name + '">' + item.code + ' - ' + item.name + '</span></td>');
            var disabled = 'disabled';
            if(item.canDelete){
                disabled = '';
            }
            var secondColumn = $('<td class="remove-node"><i class="trigger fa fa-trash ' + disabled + '" title="' + i18n.CLASSIFICATION_BUTTON_DELETE + '"></i></td>');
            line.append(firstColumn);
            line.append(secondColumn);
            tbody.append(line);
        });
    };

    function bindNewNode() {
        treeClassification.tree.find('thead .add-node').click(function () {
            $(this).attr('disabled', true);
            var tbody = treeClassification.tree.find('tbody');
            var newNode = $('<tr id="node-new" class="line-node new root"></tr>');
            var firstColumn = $('<td class="node"></td>');

            var codeInput = $('<input type="text" id="newNode-code" class="form-control" />');
            var groupCode = $('<div class="form-group col-xs-2"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" aria-hidden="true"></span></div>');
            groupCode.prepend(codeInput);
            var groupZero = $('<div class="form-group input-zero"></div>');
            var spanZero = $('<span>' + i18n.CLASSIFICATION_BUTTON_ZERO + '</span>');
            var checkboxZero = $('<input type="checkbox" />');
            groupZero.append(spanZero);
            groupZero.append(checkboxZero);
            var nameInput = $('<input type="text" id="newNode-name" placeholder="' + i18n.CLASSIFICATION_NAME_LABEL + '" class="form-control"/>');
            application.bindKeyUp(nameInput, save, cancelNewNode);
            var groupName = $('<div class="form-group col-xs-7"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="' + i18n.DEFAULT_FIELD_REQUIRED.replace('%', i18n.CLASSIFICATION_NAME_LABEL) + '" aria-hidden="true"></span></div>');
            groupName.prepend(nameInput);

            firstColumn.append(groupCode);
            var selectedNode = treeClassification.getSelectedNode();
            if (selectedNode) {
                firstColumn.append(groupZero);
            }
            firstColumn.append(groupName);

            var lastColumn = $('<td class="add-node"></td>');
            var buttonSave = $('<i class="trigger fa fa-check" title="' + i18n.CLASSIFICATION_BUTTON_CREATE + '"></i>');
            bindSave(buttonSave);
            var buttonCancel = $('<i class="trigger fa fa-remove" title="' + i18n.DEFAULT_BUTTON_CANCEL_LABEL + '"></i>');
            bindCancel(buttonCancel);

            lastColumn.append(buttonSave);
            lastColumn.append(buttonCancel);

            newNode.append(firstColumn);
            newNode.append(lastColumn);
            if (selectedNode) {
                selectedNode.find('.trigger').removeClass('disabled');
                treeClassification.expand(selectedNode);
                selectedNode.after(newNode);
                var code = selectedNode.data('code');
                var children = treeClassification.getChildren(selectedNode, false);
                var childCode = code + '.' + (children.length + 1);
                codeInput.val(code + '.' + (children.length + 1));
                newNode.find('td').eq(0).css('padding-left', (parseInt(selectedNode.find('td').eq(0).css('padding-left').replace('px', '')) + 15) + 'px');
            } else {
                var code = (tbody.find('tr.root').length + 1) + '.0';
                codeInput.val(code);
                tbody.append(newNode);
            }
            checkboxZero.click(function(){
                var last = codeInput.val().split('.');
                if($(this).is(':checked')){
                    last[last.length - 1] = '0' + last[last.length - 1];
                }else{
                    last[last.length - 1] = parseInt(last[last.length - 1]);
                }
                var code = '';
                var separator = '';
                $.each(last, function(index, item){
                    code = code + separator + item;
                    separator = '.';
                });
                codeInput.val(code);
            });
            nameInput.focus();
        });
    };

    function bindSave(buttonSave) {
        buttonSave.click(function () {
            save();
        });
    };
    
    function bindEdit(){
        treeClassification.tree.find('tbody tr td span.label').click(function(){
            var span = $(this);
            var td = span.parent();
            var div = $('<div class="form-group col-xs-6 ignore"><span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" aria-hidden="true"></span></div>');
            var input = $('<input type="text" class="form-control ignore" value="' + span.data('input') + '" />');
            var enter = function(){
                var classification = {id: td.parent().data('id'), name: input.val()};
                var callback = function () {
                    initTree();
                };
                service.update(classification, callback);
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
        var codeInput = treeClassification.tree.find('tr#node-new input#newNode-code');
        var nameInput = treeClassification.tree.find('tr#node-new input#newNode-name');
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
            var classification = {code: codeInput.val(), name: nameInput.val(), owner: 'admin'};
            classification.parentClassification = treeClassification.getSelectedNode() ? treeClassification.getSelectedNode().data('id') : null;
            var callback = function () {
                treeClassification.tree.find('thead .add-node').attr('disabled', false);
                initTree();
            };
            service.save(classification, callback);
        }
    };
    
    function bindCancel(buttonCancel) {
        buttonCancel.click(function () {
            cancelNewNode();
        });
    };

    function cancelNewNode() {
        var selectedNode = treeClassification.getSelectedNode();
        if(selectedNode){
            var children = treeClassification.getChildren(selectedNode, false);
            if (children.length === 0) {
                selectedNode.find('.node .trigger').addClass('disabled');
                application.removeObject(treeClassification.getExpandNodeList(), selectedNode.data('id'));
            }
        }
        treeClassification.tree.find('thead .add-node').attr('disabled', false);
        treeClassification.tree.find('tr#node-new').remove();
    };

    function bindRemoveNode() {
        treeClassification.tree.find('.trigger.fa.fa-trash:not(.disabled)').click(function () {
            var node = $(this).closest('tr.line-node');
            var callback = function () {
                initTree();
            };
            var action = function () {
                service.remove(node.data('id'), callback);
            };
            application.confirmFunction(action, i18n.CLASSIFICATION_CONFIRM_DELETE);
        });
    };
    
    self.initTree = initTree;
}
