<%@ page import="br.com.archive.domain.StorageType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storageType.label', default: 'StorageType')}" />
        <title><g:message code="menu.edit.storageType" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.edit.storageType" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.storageType" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${storageTypeInstance}">
            <div class="alert alert-danger" role="alert">
            <g:eachError bean="${storageTypeInstance}" var="error">
                <g:message error="${error}"/>
                <br />
            </g:eachError>
            </div>
        </g:hasErrors>
        <g:form name="form" url="[resource:storageTypeInstance, action:'update']" method="PUT" >
            <g:hiddenField name="version" value="${storageTypeInstance?.version}" />
            <fieldset class="form">
                <g:render template="form"/>
                <div class="col-xs-12 form-group buttons">
                    <button type="button" data-form="form" class="btn btn-default submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.update.label" />
                    </button>
                    <button type="button" data-form="deleteForm" data-message="<g:message code="default.button.delete.confirm.message" />" class="btn btn-danger confirm-submit">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.delete.label" />
                    </button>
                    <button type="button" data-path="<g:createLink action="show" resource="${storageTypeInstance}" />" class="btn btn-warning redirect">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
        <g:form name="deleteForm" url="[resource:storageTypeInstance, action:'delete']" method="DELETE">
        </g:form>
    </body>
</html>
