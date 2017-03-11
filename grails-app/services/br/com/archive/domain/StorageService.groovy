package br.com.archive.domain

import grails.transaction.Transactional;
import br.com.archive.domain.Storage;

@Transactional
class StorageService {

    def delete(Storage storageInstance) {
        def parentInstance = storageInstance.parentStorage;
        storageInstance.delete flush:true
        if(parentInstance != null){
            syncChildrenCodes(parentInstance);
        }
    }
    
    def syncChildrenCodes(Storage parentInstance){
        def index = 1;
        parentInstance.childrenStorage.sort{it.code}.each{childInstance->
            childInstance.code = parentInstance.code + '.' + index;
            childInstance.save flush: true;
            syncChildrenCodes(childInstance);
            index++;
        };
    }
}
