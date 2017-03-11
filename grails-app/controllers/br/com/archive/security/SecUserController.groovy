package br.com.archive.security

import static org.springframework.http.HttpStatus.*;
import grails.transaction.Transactional;
import grails.converters.JSON;
import grails.plugin.springsecurity.annotation.Secured;

@Secured(["ROLE_ADMIN"])
@Transactional(readOnly = true)
class SecUserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService;
    def passwordEncoder;

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SecUser.list(params), model:[secUserInstanceCount: SecUser.count()]
    }

    def show(SecUser secUserInstance) {
        def secUserSecRoles = SecUserSecRole.findAllBySecUser(secUserInstance);
        [secUserInstance: secUserInstance, secRoleInstance: secUserSecRoles[0]?.secRole]
    }

    def create() {
        respond new SecUser(params)
    }
    
    def find() {
        def criteria = SecUser.createCriteria();
        def secUserList = criteria.list {
            or {
                if(params.term != null){
                    ilike("name", params.term+"%")
                    ilike("username", params.term+"%")
                }
            }
            order("name", "asc")
        }
        def response = secUserList.collect { secUser->
            ["id": secUser.id,
                "name": secUser.name,
                "username": secUser.username,
                "accountExpired": secUser.accountExpired,
                "accountLocked": secUser.accountLocked,
                "dateCreated": secUser.dateCreated]
        }
        render response as JSON;
    }

    @Transactional
    def save(SecUser secUserInstance) {
        def secRoleInstance = SecRole.get(params.role.id);
        if (secUserInstance == null || secRoleInstance == null) {
            notFound()
            return
        }
        secUserInstance.owner = springSecurityService.currentUser.username;
        if (secUserInstance.hasErrors()) {
            respond secUserInstance.errors, view:'create'
            return
        }
        secUserInstance.save flush:true
        SecUserSecRole.create(secUserInstance, secRoleInstance);
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'secUser.created.message')
                redirect secUserInstance
            }
            '*' { respond secUserInstance, [status: CREATED] }
        }
    }

    def edit(SecUser secUserInstance) {
        def secUserSecRoles = SecUserSecRole.findAllBySecUser(secUserInstance);
        [secUserInstance: secUserInstance, secRoleInstance: secUserSecRoles[0]?.secRole]
    }
    
    def editPassword(SecUser secUserInstance) {
        respond secUserInstance
    }

    @Transactional
    def update(SecUser secUserInstance) {
        def secRoleInstance = SecRole.get(params.role.id);
        if (secUserInstance == null || secRoleInstance == null) {
            notFound()
            return
        }
        if (secUserInstance.hasErrors()) {
            respond secUserInstance.errors, view:'edit'
            return
        }
        SecUserSecRole.removeAll(secUserInstance);
        SecUserSecRole.create(secUserInstance, secRoleInstance);
        secUserInstance.save flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'secUser.updated.message')
                redirect secUserInstance
            }
            '*'{ respond secUserInstance, [status: OK] }
        }
    }
    
    @Transactional
    def updatePassword(SecUser secUserInstance) {
        if (secUserInstance == null) {
            notFound()
            return
        }
        secUserInstance.password = params.newPassword;
        secUserInstance.save flush: true;
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'secUser.updatedPassword.message')
                redirect secUserInstance
            }
            '*'{ respond secUserInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SecUser secUserInstance) {
        if (secUserInstance == null) {
            notFound()
            return
        }
        SecUserSecRole.removeAll(secUserInstance);
        secUserInstance.delete flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'secUser.deleted.message')
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    @Transactional
    def changePassword() {
        String enteredPassword = params.oldPassword;
        println params
        def secUserInstance = SecUser.findById(springSecurityService.currentUser.id);
        if(passwordEncoder.isPasswordValid(secUserInstance.password, enteredPassword, null)){
            secUserInstance.password = params.newPassword;
            secUserInstance.save flush: true;
            request.withFormat {
                '*'{ render status: OK }
            }
        }else{
            request.withFormat {
                '*'{ render status: NOT_ACCEPTABLE }
            }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'secUser.notFound.message')
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
