/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var storageType;
$(document).ready(function(){
    storageType = new StorageType(application);
});

function StorageType(application){
    
    var application = application;
    
    (function init(){
        application.setSearchFunction(search);
    })();
    
    function search(term){
        $.ajax({
            url: "/archive/storageType/find",
            type: "post",
            dataType: 'json',
            data: {term: term},
            success: function(data) {
                application.injectHtmlResult(createLine, data);
            },
            error: function(xhr) {
                if(xhr.status === 403){
                    application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
                }else{
                    application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
                }
            }
        });
    }
    
    function createLine(storageType, isOdd){
        storageType.dateCreated = application.dateUtil.formatDate(storageType.dateCreated);
        var compile = '';
        var classLine = isOdd ? "odd" : "even";
        var tr = '<tr class="link '+classLine+'" data-path="/archive/storageType/show/'+storageType.id+'">';
        var tds = '<td>'+storageType.name+'</td><td>'+storageType.description+'</td><td>'+storageType.owner+'</td><td>'+storageType.dateCreated+'</td>';
        return tr+tds+'</tr>';
    }
}
