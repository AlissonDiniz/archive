package br.com.archive.domain

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FileController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
    }
    
    def show(File fileInstance) {
        [fileInstance: fileInstance, classificationInstance: fileInstance.parentClassification, storageInstance: fileInstance.parentStorage]
    }
    
    def search() {
    }
    
    def resultSearch() {
        def criteria = File.createCriteria();
        def fileInstanceList = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
                if(params.tags){
                    params.tags.split(",").each{tag->
                        ilike("tagList", '%'+tag+'%')
                    }
                }
                if(params.subject){
                    ilike("subject", '%'+params.subject+'%')
                }
                if(params.note){
                    ilike("note", '%'+params.note+'%')
                }
                if(params.periodInit){
                    gt("periodInit", new Date().parse(message(code: 'default.date.format'), params.periodInit))
                }
                if(params.periodEnd){
                    lt("periodEnd", new Date().parse(message(code: 'default.date.format'), params.periodEnd))
                }
                if(params.type){
                    type{
                        idEq(params.type.toLong())
                    }
                }
            }
            order("code", "asc")
        }
        render (view: 'resultSearch', model:[fileInstanceList: fileInstanceList])
    }
    
    def report() {
    }
    
    def resultReport() {
        def criteria = File.createCriteria();
        def fileListInstance = criteria.list {
            and {
                if(params.code){
                    ilike("code", params.code+'%')
                }
                if(params.name){
                    ilike("name", params.name+'%')
                }
                if(params.tags){
                    params.tags.split(",").each{tag->
                        ilike("tagList", '%'+tag+'%')
                    }
                }
                if(params.subject){
                    ilike("subject", '%'+params.subject+'%')
                }
                if(params.note){
                    ilike("note", '%'+params.note+'%')
                }
                if(params.periodInit){
                    gt("periodInit", new Date().parse(message(code: 'default.date.format'), params.periodInit))
                }
                if(params.periodEnd){
                    lt("periodEnd", new Date().parse(message(code: 'default.date.format'), params.periodEnd))
                }
                if(params.type){
                    type{
                        idEq(params.type.toLong())
                    }
                }
            }
            order("code", "asc")
        }
        if(params.detail != null){
            render (view: 'resultReportDetail', model:[parameters: [detail: true], fileListInstance: fileListInstance])
        }else{
            render (view: 'resultReport', model:[parameters: [detail: false], fileListInstance: fileListInstance])
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileInstance.label', default: 'File'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
