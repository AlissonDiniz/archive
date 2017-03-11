package br.com.archive.domain

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import br.com.archive.to.ClassificationTO;
import br.com.archive.helper.TreeHelper;

@Transactional(readOnly = true)
class ClassificationRestController {

    static responseFormats = ['json', 'xml']
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def springSecurityService;
    def classificationService;
    
    def list(){
        def classificationInstanceList = Classification.list().collect{classification->
            new ClassificationTO(classification);
        }
        respond TreeHelper.createTree(classificationInstanceList);
    }
    
    @Transactional
    def save(Classification classificationInstance) {
        if (classificationInstance == null) {
            render status: NOT_FOUND
            return
        }
        classificationInstance.owner = springSecurityService.currentUser.username;
        classificationInstance.validate()
        if (classificationInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }
        classificationInstance.save flush:true
        respond classificationInstance, [status: CREATED]
    }
    
    @Transactional
    def update() {
        def classificationInstance = Classification.findById(params.id);
        if (classificationInstance == null) {
            render status: NOT_FOUND
            return
        }
        classificationInstance.name = params.name;
        classificationInstance.save flush:true
        respond classificationInstance, [status: OK]
    }
    
    @Transactional
    def delete(Classification classificationInstance) {
        if (classificationInstance == null) {
            render status: NOT_FOUND
            return
        }
        classificationService.delete(classificationInstance);
        render status: NO_CONTENT
    }
}
