
<%@ page import="br.com.archive.security.SecUser" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
        <title><g:message code="menu.show.user" args="[entityName]" /></title>
        <r:require module="secUser"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.user" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.user" />
                </a>
            </li>
            <li role="presentation">
                <a href="<g:createLink action="create" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.user" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <div id="show-secUser" class="content scaffold-show" role="main">
            <ol class="property-list secUser">
                <li>
                    <p class="text-title"><g:message code="secUser.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${secUserInstance}" field="name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.username.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${secUserInstance}" field="username"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.enabled.label" /></p>
                    <p class="text-primary"><g:formatBoolean boolean="${secUserInstance?.enabled}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.accountLocked.label" /></p>
                    <p class="text-primary"><g:formatBoolean boolean="${secUserInstance?.accountLocked}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.accountExpired.label" /></p>
                    <p class="text-primary"><g:formatBoolean boolean="${secUserInstance?.accountExpired}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.passwordExpired.label" /></p>
                    <p class="text-primary"><g:formatBoolean boolean="${secUserInstance?.passwordExpired}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="secUser.role.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${secRoleInstance}" field="description"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${secUserInstance}" field="owner"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${secUserInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${secUserInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
            <div class="col-xs-12 form-group buttons">
                <button type="button" data-path="<g:createLink action="edit" resource="${secUserInstance}" />" class="btn btn-default redirect">
                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <g:message code="default.button.edit.label" />
                </button>
                <button type="button" data-path="<g:createLink action="editPassword" resource="${secUserInstance}" />" class="btn btn-default redirect">
                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <g:message code="secUser.button.editPassword.label" />
                </button>
            </div>
        </div>
    </body>
</html>
