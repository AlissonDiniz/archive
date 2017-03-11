package br.com.archive.domain

import grails.converters.JSON;
import static org.springframework.http.HttpStatus.*;
import grails.transaction.Transactional;
import br.com.archive.to.FileTO;

@Transactional(readOnly = true)
class FileRestController {

    static responseFormats = ['json', 'xml']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService;
    
    def list(Storage storageInstance){
        if (storageInstance == null) {
            render status: NOT_FOUND
            return
        }
        respond storageInstance.fileList.sort{it.code}.collect{file-> new FileTO(file)};
    }
    
    def getLastFileCode(Classification classificationInstance){
        def criteria = File.createCriteria();
        def fileList = criteria.list {
            parentClassification{
                idEq(classificationInstance.id)
            }
            order("code", "desc")
        }
        def lastInt = 0;
        def lastCode = '';
        if(fileList.size() > 0){
            lastInt = fileList.get(0).code.split('-')[1].toInteger();
        }
        lastInt++; 
        if(lastInt < 10){
            lastCode = '000' + lastInt.toString();
        }else if(lastInt < 100){
            lastCode = '00' + lastInt.toString();
        }else if(lastInt < 1000){
            lastCode = '0' + lastInt.toString();
        }else{
            lastCode = '' + lastInt.toString();
        }
        def response = [lastCode: lastCode];
        render response as JSON;
    }

    @Transactional
    def save(File fileInstance) {
        if (fileInstance == null) {
            render status: NOT_FOUND
            return
        }
        fileInstance.owner = springSecurityService.currentUser.username;
        fileInstance.validate()
        if (fileInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }
        fileInstance.save flush:true
        respond fileInstance, [status: CREATED]
    }
    
    @Transactional
    def update(File fileInstance) {
        if (fileInstance == null) {
            render status: NOT_FOUND
            return
        }
        fileInstance.validate();
        if (fileInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }
        fileInstance.save flush:true
        respond fileInstance, [status: OK]
    }
    
    @Transactional
    def delete(File fileInstance) {
        if (fileInstance == null) {
            render status: NOT_FOUND
            return
        }
        fileInstance.delete flush: true;
        render status: NO_CONTENT
    }
}
