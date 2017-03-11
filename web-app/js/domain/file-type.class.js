/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var fileType;
$(document).ready(function(){
    fileType = new FileType(application);
});

function FileType(application){
    
    var application = application;
    
    (function init(){
        application.setSearchFunction(search);
    })();
    
    function search(term){
        $.ajax({
            url: "/archive/fileType/find",
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
    
    function createLine(fileType, isOdd){
        fileType.dateCreated = application.dateUtil.formatDate(fileType.dateCreated);
        var compile = '';
        var classLine = isOdd ? "odd" : "even";
        var tr = '<tr class="link '+classLine+'" data-path="/archive/fileType/show/'+fileType.id+'">';
        var tds = '<td>'+fileType.name+'</td><td>'+fileType.description+'</td><td>'+fileType.owner+'</td><td>'+fileType.dateCreated+'</td>';
        return tr+tds+'</tr>';
    }
}
