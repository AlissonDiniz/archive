<%@ page import="br.com.archive.security.SecUser" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
        <title><g:message code="menu.edit.user" args="[entityName]" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.edit.user" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.user" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${secUserInstance}">
            <div class="alert alert-danger" role="alert">
                <g:eachError bean="${secUserInstance}" var="error">
                    <g:message error="${error}"/>
                    <br />
                </g:eachError>
            </div>
        </g:hasErrors>
        <g:form name="form" url="[resource:secUserInstance, action:'update']" method="PUT" >
            <g:hiddenField name="version" value="${secUserInstance?.version}" />
            <fieldset class="form">
                <div class="col-xs-8 form-group not-update">
                    <label for="username">
                        <g:message code="secUser.username.label" />
                    </label>
                    <p class="text-primary"><g:fieldValue bean="${secUserInstance}" field="username"/></p>
                </div>
                <div class="col-xs-8 form-group ${hasErrors(bean: secUserInstance, field: 'name', 'has-error')}">
                    <label for="name">
                        <g:message code="secUser.name.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="name" class="validate required form-control" placeholder="${message (code: "secUser.name.label")}" value="${secUserInstance?.name}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-8 form-group">
                    <label for="role">
                        <g:message code="secUser.role.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select id="role" name="role.id" class="validate required form-control" from="${br.com.archive.security.SecRole.list()}" optionKey="id" value="${secRoleInstance?.id}"/>
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-confirm="${message (code: "default.field.confirm")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-8 checkbox">
                    <label for="enabled">
                        <g:checkBox name="enabled" value="${secUserInstance?.enabled}" />
                        <g:message code="secUser.enabled.label" />
                    </label>
                </div>
                <div class="col-xs-8 checkbox">
                    <label for="accountExpired">
                        <g:checkBox name="accountExpired" value="${secUserInstance?.accountExpired}" />
                        <g:message code="secUser.accountExpired.label" />
                    </label>
                </div>
                <div class="col-xs-8 checkbox">
                    <label for="accountLocked">
                        <g:checkBox name="accountLocked" value="${secUserInstance?.accountLocked}" />
                        <g:message code="secUser.accountLocked.label" />
                    </label>
                </div>
                <div class="col-xs-8 checkbox">
                    <label for="passwordExpired">
                        <g:checkBox name="passwordExpired" value="${secUserInstance?.passwordExpired}" />
                        <g:message code="secUser.passwordExpired.label" />
                    </label>
                </div>
                <div class="col-xs-12 form-group buttons">
                    <button type="button" data-form="form" class="btn btn-default submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.update.label" />
                    </button>
                    <button type="button" data-form="deleteForm" data-message="<g:message code="default.button.delete.confirm.message" />" class="btn btn-danger confirm-submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.delete.label" />
                    </button>
                    <button type="button" data-path="<g:createLink action="show" resource="${secUserInstance}" />" class="btn btn-warning redirect">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
        <g:form name="deleteForm" url="[resource:secUserInstance, action:'delete']" method="DELETE">
        </g:form>
    </div>
</body>
</html>
