package br.com.archive.domain

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import br.com.archive.to.ClassificationTO;
import br.com.archive.to.FileTO;
import br.com.archive.helper.TreeReportHelper;

@Transactional(readOnly = true)
class ClassificationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService;

    def index() {
    }
    
    def search() {
    }
    
    def show(Classification classificationInstance) {
        [classificationInstance: classificationInstance]
    }
    
    def resultSearch() {
        def criteria = Classification.createCriteria();
        def classificationInstanceList = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
            }
            order("code", "asc")
        }
        render (view: 'resultSearch', model:[classificationInstanceList: classificationInstanceList])
    }
    
    def report() {
    }

    def resultReport() {
        def criteria = Classification.createCriteria();
        def classificationInstanceList = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
            }
            order("code", "asc")
        }.collect{classification ->
            if(params.typeReport.equals('ANALYTIC')){
                def fileTOList = classification.fileList.collect{file -> new FileTO(file)};
                new ClassificationTO(classification, fileTOList);
            }else{
                new ClassificationTO(classification);
            }
        }
        def tree = TreeReportHelper.createTree(classificationInstanceList);
        if(params.detail != null){
            render (view: 'resultReportDetail', model:[parameters: [typeReport: message(code: 'br.com.archive.domain.ClassificationReportType.'+params.typeReport), detail: true], classificationInstanceTree: tree])
        }else{
            render (view: 'resultReport', model:[parameters: [typeReport: message(code: 'br.com.archive.domain.ClassificationReportType.'+params.typeReport), detail: false], classificationInstanceTree: tree])
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'classificationInstance.label', default: 'Classification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
