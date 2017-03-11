/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 Created on : 23/04/2015, 23:31:23
 Author     : Alisson Diniz
 */

function StorageService(application) {

    var application = application;
    var self = this;

    function save(storage, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/storageRest/save",
            type: "POST",
            dataType: 'json',
            data: storage
        }).done(function (data) {
            if(callback){
                callback(data);
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            }
            if (xhr.status === 406) {
                application.ShowMessage(i18n.DEFAULT_CODE_UNIQUE);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function update(storage, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/storageRest/update",
            type: "POST",
            dataType: 'json',
            data: storage
        }).done(function (data) {
            if(callback){
                callback(data);
            }
        }).fail(function (xhr) {
            if (xhr.status === 403) {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_DENIED);
            }
            if (xhr.status === 406) {
                application.ShowMessage(i18n.DEFAULT_CODE_UNIQUE);
            } else {
                application.ShowMessage(i18n.DEFAULT_SYSTEM_ERROR + xhr.status);
            }
        }).always(function () {
            application.CloseWait();
        });
    };
    
    function list(callback) {
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
    
    function remove(id, callback) {
        application.ShowWait();
        $.ajax({
            url: "/archive/storageRest/delete/" + id,
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

    self.save = save;
    self.update = update;
    self.list = list;
    self.remove = remove;
}
