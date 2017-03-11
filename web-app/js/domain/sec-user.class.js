/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var secUser;
$(document).ready(function(){
    secUser = new SecUser(application);
});

function SecUser(application){
    
    var application = application;
    
    (function init(){
        application.setSearchFunction(search);
    })();
    
    function search(term){
        $.ajax({
            url: "/archive/secUser/find",
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
    
    function createLine(secUser, isOdd){
        secUser.accountExpired = secUser.accountExpired ? i18n.DEFAULT_BOOLEAN_TRUE : i18n.DEFAULT_BOOLEAN_FALSE; 
        secUser.accountLocked = secUser.accountLocked ? i18n.DEFAULT_BOOLEAN_TRUE : i18n.DEFAULT_BOOLEAN_FALSE;
        secUser.dateCreated = application.dateUtil.formatDate(secUser.dateCreated);
        var compile = '';
        var classLine = isOdd ? "odd" : "even";
        var tr = '<tr class="link '+classLine+'" data-path="/archive/secUser/show/'+secUser.id+'">';
        var tds = '<td>'+secUser.name+'</td><td>'+secUser.username+'</td><td>'+secUser.accountExpired+'</td><td>'+secUser.accountLocked+'</td><td>'+secUser.dateCreated+'</td>';
        return tr+tds+'</tr>';
    }
}
