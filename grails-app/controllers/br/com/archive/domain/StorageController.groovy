package br.com.archive.domain

import static org.springframework.http.HttpStatus.*;
import grails.transaction.Transactional;
import br.com.archive.to.StorageTO;
import br.com.archive.to.FileTO;
import br.com.archive.helper.TreeReportHelper;

@Transactional(readOnly = true)
class StorageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
    }
    
    def search() {
    }
    
    def show(Storage storageInstance) {
        [storageInstance: storageInstance]
    }
    
    def resultSearch() {
        def criteria = Storage.createCriteria();
        def storageInstanceList = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
                if(params.type){
                    type{
                        idEq(params.type.toLong())
                    }
                }
            }
            order("code", "asc")
        }
        render (view: 'resultSearch', model:[storageInstanceList: storageInstanceList])
    }
    
    def report() {
    }
    
    def resultReport() {
        def criteria = Storage.createCriteria();
        def storageInstanceList = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
                if(params.type){
                    type{
                        idEq(params.type.toLong())
                    }
                }
            }
            order("code", "asc")
        }.collect{storage ->
            if(params.typeReport.equals('ANALYTIC')){
                def fileTOList = storage.fileList.collect{file -> new FileTO(file)};
                new StorageTO(storage, fileTOList);
            }else{
                new StorageTO(storage);
            }
        }
        def tree = TreeReportHelper.createTree(storageInstanceList);
        if(params.detail != null){
            render (view: 'resultReportDetail', model:[parameters: [typeReport: message(code: 'br.com.archive.domain.StorageReportType.'+params.typeReport), detail: true], storageInstanceTree: tree])
        }else{
            render (view: 'resultReport', model:[parameters: [typeReport: message(code: 'br.com.archive.domain.StorageReportType.'+params.typeReport), detail: false], storageInstanceTree: tree])
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'storageInstance.label', default: 'Storage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
