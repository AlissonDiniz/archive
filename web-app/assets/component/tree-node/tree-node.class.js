/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */

function TreeNode(applicationVar, treeVar) {

    var self = this;
    var application = applicationVar;
    var tree = treeVar;
    var data = null;
    var selectedNode = null;
    var selectedNodeCustom = null;
    var unSelectedNodeCustom = null;
    var expandNodeList = new Array();
    var filterInput = null;

    function init(dataVar) {
        data = dataVar;
        render();
        initialize();
    };
    
    function initCustom(renderCustom){
        renderCustom();
        initialize();
    };

    function render() {
        var tbody = tree.find('tbody');
        tbody.empty();
        $.each(data, function (index, item) {
            var root = item.parentId ? 'parent-' + item.parentId : 'root';
            var id = item.parentId ? 'node-' + item.parentId + '-' + item.id : 'node-' + item.id;
            var line = $('<tr id="' + id + '" data-id="' + item.id + '" data-code="' + item.code + '" class="line-node ' + root + ' hide"></tr>');
            var firstColumn = $('<td class="node"><i class="trigger fa fa-angle-right"></i><span class="label">' + item.code + ' - ' + item.name + '</span></td>');
            line.append(firstColumn);
            tbody.append(line);
        });
    };

    function initialize() {
        var treeNodes = tree.find('.line-node.root');
        $.each(treeNodes, function (i, item) {
            var node = $(item);
            node.removeClass('hide');
            prepareChildren(node, 1);
        });
        tree.find('.line-node .node .trigger').addClass('collapse');
        bindSelectNode();
        bindTriggerNode();
        if(filterInput && filterInput.val()){
            filter(filterInput.val());
        }
        $.each(expandNodeList.slice(0), function(index, item){
            var node = tree.find('[data-id="' + item + '"]');
            if(node.length){
                application.removeObject(expandNodeList, item);
                expand(node);
            }
        });
        if (selectedNode) {
            var node = tree.find('#' + selectedNode.attr('id'));
            if(node.length){
                selectedNode = node;
                selectedNode.addClass('selected');
            }
        }
    };

    function prepareChildren(node, level) {
        var children = getChildren(node, false);
        if (children.length === 0) {
            node.find('.node .trigger').addClass('disabled');
        } else {
            $.each(children, function (i, item) {
                var childNode = $(item);
                var firstColumn = childNode.find('.node');
                firstColumn.css('padding-left', (parseInt(firstColumn.css('padding-left').replace('px', '')) + (level * 15)) + 'px');
                prepareChildren(childNode, level + 1);
            });
        }
    };

    function bindSelectNode() {
        tree.find('.line-node').click(function (e) {
            var target = $(e.target);
            if (!target.hasClass('trigger') && !target.hasClass('ignore')) {
                if (selectedNode) {
                    if (selectedNode.attr('id') === $(this).attr('id')) {
                        unSelectNode();
                    } else {
                        selectedNode.removeClass('selected');
                        selectedNode = $(this);
                        selectedNode.addClass('selected');
                        if(selectedNodeCustom){
                            selectedNodeCustom();
                        }
                    }
                } else {
                    selectedNode = $(this);
                    selectedNode.addClass('selected');
                    if(selectedNodeCustom){
                        selectedNodeCustom();
                    }
                }
            }
        });
    };
    
    function initFilterNode(wrapper){
        wrapper.css('float', 'right');
        wrapper.css('position', 'relative');
        var container = $('<div class="search-wrapper col-xs-10 form-group search-node"></div>');
        var input = $('<input type="text" name="search-node" class="form-control" placeholder="' + i18n.DEFAULT_QUICKSEARCH_LABEL + '" value="" id="search-node">');
        filterInput = input;
        var searchButton = $('<span class="glyphicon search-icon glyphicon-search form-control-feedback" aria-hidden="true"></span>');
        var cancelButton = $('<span class="glyphicon search-cancel glyphicon-remove-sign form-control-feedback" aria-hidden="true"></span>');
        container.append(input);
        container.append(searchButton);
        container.append(cancelButton);
        wrapper.append(container);
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
            input.val('');
            cancelButton.hide();
            searchButton.show();
            filter(input.val());
        });
    };

    function unSelectNode() {
        if(selectedNode){
            selectedNode.removeClass('selected');
            selectedNode = null;
            if(unSelectedNodeCustom){
                unSelectedNodeCustom();
            }
        }
    };

    function bindTriggerNode() {
        var triggerList = tree.find('.line-node .node .trigger');
        triggerList.click(function () {
            var trigger = $(this);
            var node = trigger.closest('tr.line-node');
            if (trigger.hasClass('collapse')) {
                expand(node);
            } else {
                collapse(node);
            }
        });
    };

    function collapse(node) {
        application.removeObject(expandNodeList, node.data('id'));
        var trigger = node.find('.node .trigger');
        if(!trigger.hasClass('collapse')){
            trigger.removeClass('expand').addClass('collapse');
            trigger.removeClass('fa-angle-down').addClass('fa-angle-right');
            var children = getChildren(node, false);
            $.each(children, function (i, item) {
                var childNode = $(item);
                childNode.addClass('hide');
                collapse(childNode, childNode.find('.node .trigger'));
            });
        }
    };

    function expand(node) {
        expandNodeList.push(node.data('id'));
        var trigger = node.find('.node .trigger');
        if(!trigger.hasClass('expand')){
            trigger.removeClass('collapse').addClass('expand');
            trigger.removeClass('fa-angle-right').addClass('fa-angle-down');
            var children = getChildren(node, false);
            $.each(children, function (i, item) {
                var childNode = $(item);
                childNode.removeClass('hide');
            });
        }
    };
    
    function expandAll() {
        $.each(tree.find('.line-node'), function (i, item) {
            var node = $(item);
            if(!node.hasClass('filtered')){
                expand(node);
            }
        });
    };
    
    function collapseAll() {
        $.each(tree.find('.line-node'), function (i, item) {
            var node = $(item);
            collapse(node);
        });
    };

    function getChildren(node, recursive) {
        var children = tree.find('.line-node.parent-' + node.data('id'));
        var arrayNodes = [];
        $.each(children, function (i, item) {
            var childNode = $(item);
            arrayNodes.push(childNode);
        });
        return arrayNodes;
    };
    
    function setSelectedNodeCustom(selectedNodeCustomVar){
        selectedNodeCustom = selectedNodeCustomVar;
    };
    self.setSelectedNodeCustom = setSelectedNodeCustom;
    
    function setUnSelectedNodeCustom(unSelectedNodeCustomVar){
        unSelectedNodeCustom = unSelectedNodeCustomVar;
    };
    self.setUnSelectedNodeCustom = setUnSelectedNodeCustom;
    
    function filter(term){
        if(selectedNode){
            unSelectNode();
        }
        $.each(tree.find('.line-node'), function (i, item) {
            var node = $(item);
            var nodeLabel = node.find('.label').text();
            if(nodeLabel.toUpperCase().indexOf(term.toUpperCase()) > -1){
                node.removeClass('filtered');
            }else{
                node.addClass('filtered');
            }
        });
        if(term){
            expandAll();
        }else{
            collapseAll();
        }
    };
    self.filter = filter;
    
    self.init = init;
    self.initCustom = initCustom;
    self.initFilterNode = initFilterNode;
    self.tree = tree;
    
    function getSelectedNode(){
        return selectedNode;
    };
    self.getSelectedNode = getSelectedNode;
    self.expand = expand;
    self.collapse = collapse;
    self.getChildren = getChildren;
    self.getChildren = getChildren;
    function getExpandNodeList(){
        return expandNodeList;
    };
    self.getExpandNodeList = getExpandNodeList;
}

