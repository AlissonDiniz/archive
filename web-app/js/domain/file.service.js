/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */

function FileService(application) {

    var application = application;
    var self = this;
    
    function listStorage(callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/storageRest/list",
            type: "GET",
            dataType: 'json'
        }).done(function (data) {
            callback(data);
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function listClassification(callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/classificationRest/list",
            type: "GET",
            dataType: 'json'
        }).done(function (data) {
            callback(data);
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function getLastFileCode(classificationId, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/fileRest/getLastFileCode/"+classificationId,
            type: "GET",
            dataType: 'json',
        }).done(function (data) {
            if(callback){
                callback(data.lastCode);
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function save(file, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/fileRest/save",
            type: "POST",
            contentType: "application/json",
            dataType: 'json',
            data: JSON.stringify(file)
        }).done(function (data) {
            if(callback){
                callback(data);
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function update(file, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/fileRest/update",
            type: "PUT",
            contentType: "application/json",
            dataType: 'json',
            data: JSON.stringify(file)
        }).done(function (data) {
            if(callback){
                callback(data);
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function list(storageId, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/fileRest/list/"+storageId,
            type: "GET",
            dataType: 'json'
        }).done(function (data) {
            callback(data);
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function remove(id, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/fileRest/delete/" + id,
            type: "DELETE"
        }).done(function () {
            if(callback){
                callback();
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };

    self.listStorage = listStorage;
    self.listClassification = listClassification;
    self.getLastFileCode = getLastFileCode;
    self.save = save;
    self.update = update;
    self.list = list;
    self.remove = remove;
}
