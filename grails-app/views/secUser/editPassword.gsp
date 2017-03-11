<%@ page import="br.com.archive.security.SecUser" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
        <title><g:message code="menu.editPassword.user" args="[entityName]" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.editPassword.user" /></h3>
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
        <g:form name="form" url="[resource:secUserInstance, action:'updatePassword']" method="PUT" >
            <g:hiddenField name="version" value="${secUserInstance?.version}" />
            <fieldset class="form">
                <div class="col-xs-8 form-group not-update">
                    <label for="username">
                        <g:message code="secUser.username.label" />
                    </label>
                    <p class="text-primary"><g:fieldValue bean="${secUserInstance}" field="username"/></p>
                </div>
                <div class="col-xs-8 form-group">
                    <label for="newPassword">
                        <g:message code="secUser.newPassword.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="password" name="newPassword" class="validate required form-control" placeholder="${message (code: "secUser.newPassword.label")}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-8 form-group">
                    <label for="confirmPassword">
                        <g:message code="secUser.confirmPassword.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="password" name="confirmPassword" class="validate confirm form-control" data-field="newPassword" placeholder="${message (code: "secUser.confirmPassword.label")}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-confirm="${message (code: "default.field.confirm")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-12 form-group buttons">
                    <button type="button" data-form="form" class="btn btn-default submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.update.label" />
                    </button>
                    <button type="button" data-path="<g:createLink action="show" resource="${secUserInstance}" />" class="btn btn-warning redirect">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
    </div>
</body>
</html>
