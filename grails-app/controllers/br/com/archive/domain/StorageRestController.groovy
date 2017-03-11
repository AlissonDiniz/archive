package br.com.archive.domain

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import br.com.archive.to.StorageTO;
import br.com.archive.helper.TreeHelper;

@Transactional(readOnly = true)
class StorageRestController {

    static responseFormats = ['json', 'xml']
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def springSecurityService;
    def storageService;
    
    def list(){
        def storageInstanceList = Storage.list().collect{storage->
            new StorageTO(storage);
        }
        respond TreeHelper.createTree(storageInstanceList);
    }

    @Transactional
    def save(Storage storageInstance) {
        if (storageInstance == null) {
            render status: NOT_FOUND
            return
        }
        storageInstance.owner = springSecurityService.currentUser.username;
        storageInstance.validate()
        if (storageInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }
        storageInstance.save flush:true
        respond storageInstance, [status: CREATED]
    }
    
    @Transactional
    def update() {
        def storageInstance = Storage.findById(params.id);
        if (storageInstance == null) {
            render status: NOT_FOUND
            return
        }
        if(params.name){
            storageInstance.name = params.name;
        }
        if(params.type){
            def storageTypeInstance = StorageType.findById(params.type);
            if (storageTypeInstance == null) {
                render status: NOT_FOUND
                return
            }
            storageInstance.type = storageTypeInstance;
        }
        storageInstance.save flush:true
        respond storageInstance, [status: OK]
    }
    
    @Transactional
    def delete(Storage storageInstance) {
        if (storageInstance == null) {
            render status: NOT_FOUND
            return
        }
        storageService.delete(storageInstance);
        render status: NO_CONTENT
    }
}
