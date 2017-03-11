package br.com.archive.domain

import grails.transaction.Transactional;
import br.com.archive.domain.Classification;

@Transactional
class ClassificationService {

    def delete(Classification classificationInstance) {
        def parentInstance = classificationInstance.parentClassification;
        classificationInstance.delete flush:true
//        if(parentInstance != null){
//            syncChildrenCodes(parentInstance);
//        }
    }
    
    def syncChildrenCodes(Classification parentInstance){
        def index = 1;
        parentInstance.childrenClassification.sort{it.code}.each{childInstance->
            childInstance.code = parentInstance.code + '.' + index;
            childInstance.save flush: true;
            syncChildrenCodes(childInstance);
            index++;
        };
    }
}
